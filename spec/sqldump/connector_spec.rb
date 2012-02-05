require 'rspec'
require 'spec_helper'

module Sqldump

  describe 'Connector' do

    before(:each) do
      @options = double('options')
      @options.stub(:database).and_return('database')
      @options.stub(:database_type).and_return(:sqlite3)
      @options.stub(:username).and_return(nil)
      @options.stub(:password).and_return(nil)
    end

    describe '#connect' do

      it 'connects to the specified database' do
        database = "/tmp/foo.sqlite"
        dbh = create_dummy_database(database)
        dbh.disconnect

        @options.stub(:database).and_return(database)

        connector = Connector.new(@options)
        connector.connect do |dbh|
          sth = dbh.execute("SELECT * FROM numbers")
          sth.fetch do |row|
            row[0].should == 42
          end
          sth.finish
        end
      end

    end

    describe '#get_url' do
      it 'uses the Pg driver when postgresql is specified' do
        @options.stub(:database).and_return('numbers')
        @options.stub(:database_type).and_return(:postgresql)

        connector = Connector.new(@options)
        connector.get_url.should == 'DBI:Pg:numbers'
      end
    end

    describe '#get_user' do
      it 'returns the specified password' do
        @options.stub(:username).and_return('the_user')

        connector = Connector.new(@options)
        connector.get_user.should == 'the_user'
      end
    end

    describe '#get_user' do
      it 'returns the specified password' do
        @options.stub(:password).and_return('top_secret')

        connector = Connector.new(@options)
        connector.get_password.should == 'top_secret'
      end
    end

  end

end