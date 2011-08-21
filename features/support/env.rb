$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'aruba/cucumber'
# Ensure aruba can find the bin folder
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

def create_dummy_database_with_data(database, table_name, table_data)
  in_current_dir do
    File.delete(database) if File.exists?(database)

    converter = CukeTableDataConverter.new(table_name, table_data)

    begin
      dbh = DBI.connect("DBI:SQLite3:#{database}")

      dbh.do(converter.get_create_table_sql)
      converter.get_insert_sql.each do |sql|
        dbh.do(sql);
      end

    ensure
      dbh.disconnect if dbh
    end

  end

end
