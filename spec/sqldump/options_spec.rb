require 'rspec'
require 'spec_helper'

module Sqldump

  describe 'Options handler' do

    describe 'database and table' do
      let(:options) { Options.new(%w(-d dbname table)) }

      it "extracts the database name" do
        options.database.should == 'dbname'
      end

      it "extracts the table name" do
        options.table.should == 'table'
      end

      it "generates select sql" do
        options.sql.should match /select \* from table/i
      end

    end

    describe 'csv mode is default' do
      let(:options) { Options.new([]) }

      it "sets the mode to :csv" do
        options.dump_mode.should == :csv
      end

    end

    describe 'csv header option' do

      it "sets the options flag csv_header to true" do
        options = Options.new(%w(-d dbname -H table))
        options.csv_header.should == true
      end

    end

    describe 'insert mode option' do
      let(:options) { Options.new(%w(-i)) }

      it "sets the mode to :insert" do
        options.dump_mode.should == :insert
      end
    end

  end

end
