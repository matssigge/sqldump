require 'rspec'
require 'spec_helper'
require 'dbi'

module Sqldump

  describe "CsvFormatter" do

    def formatter_example(csv_header_option, expected_result)
      strio = StringIO.new

      options = double("Options")
      options.stub(:csv_header).and_return(csv_header_option)

      formatter = CsvFormatter.new(@sth, strio, options)
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

    it "prints column values verbatim, semicolon-separated, to supplied IO object" do
      formatter_example(false, "42,thingy\n")
    end

    it "prints column headings when given csv_header flag" do
      formatter_example(true, "number,string\n42,thingy\n")
    end

  end

end
