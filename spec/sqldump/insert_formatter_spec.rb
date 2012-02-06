require 'rspec'
require 'spec_helper'
require 'dbi'

module Sqldump

  describe InsertFormatter do

    describe "#output" do

      def formatter_example(expected_result)
        strio = StringIO.new

        options = double("Options")
        options.stub(:table).and_return('numbers_and_strings')

        formatter = InsertFormatter.new(@sth, strio, options)
        formatter.output
        strio.close

        strio.string.should == expected_result
      end

      before(:each) do
        @dbh = create_dummy_database
        @dbh.do("create table numbers_and_strings (number int, string varchar(100));")
        @dbh.do("insert into numbers_and_strings values (42, 'thingy')")
        @sth = @dbh.execute "select * from numbers_and_strings"
      end

      after(:each) do
        @sth.finish
        @dbh.disconnect
      end

      it "creates an insert statement for each row of the table" do
        formatter_example("INSERT INTO numbers_and_strings (number, string) VALUES (42, 'thingy');\n")
      end

    end

    describe "#quote" do

      class InsertFormatter
        def setup_column_type_mapping
          @column_type_by_name = {
              "number" => DBI::Type::Integer,
              "string" => DBI::Type::Varchar
          }
        end
      end

      before(:each) do
        @formatter = InsertFormatter.new(nil, nil, nil)
      end

      it "quotes a string" do
        @formatter.quote("thing", "string").should == "'thing'"
      end

      it "doesn't quote an integer" do
        @formatter.quote(17, "number").should == 17
      end

      it "returns NULL on a nil value" do
        @formatter.quote(nil, "string").should == "NULL"
      end

    end

  end

end