require 'dbi'

Given /^a database "([^"]*)" with a table "([^"]*)" with the following data$/ do |database, table_name, table|
  create_dummy_database_with_data(database, table_name, table)
end

