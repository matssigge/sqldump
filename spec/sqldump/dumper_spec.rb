require 'rspec'
require 'spec_helper'

module Sqldump

  describe 'Dumper' do

    describe 'Dump' do

      it 'Executes the select and passes an open statement handle to the supplied block' do
        dbh = create_dummy_database

        options = double('options')
        options.stub(:sql).and_return("select * from numbers")

        dumper = Dumper.new(dbh, options)
        dumper.dump do |sth|
          sth.fetch do |row|
            row[0].should == 42
          end
        end
      end

    end

  end

end