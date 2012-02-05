require 'dbi'

Given /^a database "([^"]*)" with a table "([^"]*)" with the following data$/ do |database, table_name, table|
  create_dummy_database_with_data(:sqlite3, nil, database, table_name, table)
end

Given /^a PostgreSQL database named "([^"]*)" on "([^"]*)"$/ do |database, host|
  @database = database
  @host = host
  @driver = :postgresql
end

When /^a table "([^"]*)" with the following data$/ do |table_name, table|
  create_dummy_database_with_data(@driver, @host, @database, table_name, table)
end
