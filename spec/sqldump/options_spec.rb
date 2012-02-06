require 'rspec'
require 'spec_helper'

def make_options(args)
  args << 'table' unless args[-1] == 'table'
  Sqldump::Options.new(args)
end

module Sqldump

  describe 'Options handler' do


    describe 'database and table' do
      let(:options) { make_options(%w(-d dbname table)) }

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

    describe 'host' do
      it 'sets the host to localhost if not specified' do
        options = make_options([])
        options.host.should == 'localhost'
      end

      it 'sets the host to what is specified' do
        options = make_options(%w(-S server.example.com))
        options.host.should == 'server.example.com'
      end
    end

    describe 'database type' do
      it 'sets the default to SQLite3' do
        options = make_options([])
        options.database_type.should == :sqlite3
      end

      it 'sets the type to postgresql if specified' do
        options = make_options(%w(-T postgresql))
        options.database_type.should == :postgresql
      end

      it 'pg is an alias for postgresql' do
        options = make_options(%w(-T pg))
        options.database_type.should == :postgresql
      end

      it 'sets the type to mysql if specified' do
        options = make_options(%w(-T mysql))
        options.database_type.should == :mysql
      end

    end

    describe 'username' do
      it 'sets the username to nil if not specified' do
        options = make_options([])
        options.username.should be_nil
      end

      it 'sets the username to what is specified' do
        options = make_options(%w(-U the_user))
        options.username.should == 'the_user'
      end
    end

    describe 'password' do
      it 'sets the password to nil if not specified' do
        options = make_options([])
        options.password.should be_nil
      end

      it 'sets the username to what is specified' do
        options = make_options(%w(-P top_secret table))
        options.password.should == 'top_secret'
      end
    end

    describe 'csv mode is default' do
      it "sets the mode to :csv" do
        options = make_options([])
        options.dump_mode.should == :csv
      end
    end

    describe 'csv header option' do
      it "the csv_header flag is false by default" do
        options = make_options([])
        options.csv_header.should be_false
      end

      it "sets the options flag csv_header to true" do
        options = make_options(%w(-H table))
        options.csv_header.should be_true
      end
    end

    describe 'insert mode option' do
      it "sets the mode to :insert" do
        options = make_options(%w(-i table))
        options.dump_mode.should == :insert
      end
    end

  end

end
