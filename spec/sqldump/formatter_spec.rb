require 'rspec'
require 'spec_helper'

module Sqldump

  describe Formatter do 

    context "dump_mode is :csv" do

      it "creates a CsvFormatter" do
        options = double("Options")
        options.stub(:dump_mode).and_return(:csv)
        formatter = Formatter.formatter(nil, nil, options)
        formatter.class.should == CsvFormatter
      end

    end

    context "dump_mode is :insert" do

      class InsertFormatter
        def setup_column_type_mapping
          @column_type_by_name = {}
        end
      end

      it "creates an InsertFormatter" do
        options = double("Options")
        options.stub(:dump_mode).and_return(:insert)
        formatter = Formatter.formatter(double("sth").as_null_object, nil, options)
        formatter.class.should == InsertFormatter
      end
    end
  end

end
