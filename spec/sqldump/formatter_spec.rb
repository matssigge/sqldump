require 'rspec'
require 'spec_helper'

module Sqldump

  describe Formatter do

    context "dump_mode is :csv" do

      it "creates a RawFormatter" do
        options = double("Options")
        options.stub(:dump_mode).and_return(:csv)
        formatter = Formatter.formatter(nil, nil, options)
        formatter.class.should == RawFormatter
      end

    end

    context "dump_mode is :insert" do

      it "creates an InsertFormatter" do
        options = double("Options")
        options.stub(:dump_mode).and_return(:insert)
        formatter = Formatter.formatter(nil, nil, options)
        formatter.class.should == InsertFormatter
      end
    end
  end

end
