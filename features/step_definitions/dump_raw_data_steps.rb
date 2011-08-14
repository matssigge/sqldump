require 'dbi'

Given /^a database "([^"]*)" with a table "([^"]*)" with the following data$/ do |database, table_name, table|
  create_dummy_database_with_data(database, table_name, table)
end

def create_dummy_database_with_data(database, table_name, table_data)
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
