require 'rspec'
require 'spec_helper'

module Sqldump

  describe 'Options handler' do

    describe 'database and table' do
      let(:options) { Options.new(%w(-d dbname table)) }

      it "extracts the database name" do
        options.database.should == 'dbname'
      end

      it "generates select sql" do
        options.sql.should match /select \* from table/i
      end
    end

  end

end
