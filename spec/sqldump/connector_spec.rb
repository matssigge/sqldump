require 'rspec'
require 'spec_helper'

module Sqldump

  describe 'Connector' do

    describe 'connect' do

      it 'connects to the specified database' do
        database = "/tmp/foo.sqlite"
        dbh = create_dummy_database(database)
        dbh.disconnect

        options = double('options')
        options.stub(:database).and_return(database)

        connector = Connector.new(options)
        connector.connect do |dbh|
          sth = dbh.execute("SELECT * FROM numbers")
          sth.fetch do |row|
            row[0].should == 42
          end
          sth.finish
        end
      end

    end

  end

end