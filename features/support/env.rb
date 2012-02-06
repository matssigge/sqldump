$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'aruba/cucumber'
# Ensure aruba can find the bin folder
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

def drop_database_if_exists(driver, host, database, username, password)
  case driver
    when :sqlite3
      File.delete(database) if File.exists?(database)
    when :postgresql
      DBI.connect("DBI:Pg:postgres:#{host}", username, password) do |dbh|
        dbh.do("DROP DATABASE IF EXISTS #{database}")
      end
  end
end

def get_driver_string(driver)
  case driver
    when :sqlite3
      "SQLite3"
    when :postgresql
      "Pg"
  end
end

def create_and_connect_to_database(driver, host, database, username, password, &block)
  create_database(driver, host, database, username, password)

  url = "DBI:#{get_driver_string(driver)}:#{database}"
  url += ":#{host}" if host

  if block
    DBI.connect(url, username, password, nil, &block)
  end
  DBI.connect(url, username, password)
end

def create_database(driver, host, database, username, password)
  case driver
    when :sqlite3
      # Do nothing - just connecting to the correct filename creates the database
    when :postgresql
      DBI.connect("DBI:Pg:postgres:#{host}", username, password) do |dbh|
        dbh.do("CREATE DATABASE #{database}")
      end
  end
end

def create_dummy_database_with_data(driver, host, database, table_name, table_data)
  username = 'sqldump'
  password = 'sqldump'

  in_current_dir do
    drop_database_if_exists(driver, host, database, username, password)

    converter = CukeTableDataConverter.new(table_name, table_data)

    create_and_connect_to_database(driver, host, database, username, password) do |dbh|
      dbh.do(converter.get_create_table_sql)
      converter.get_insert_sql.each do |sql|
        dbh.do(sql)
      end
    end
  end
end
