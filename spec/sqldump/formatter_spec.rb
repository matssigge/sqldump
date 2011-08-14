require 'rspec'
require 'spec_helper'

module Sqldump

  describe "Formatter" do

    describe "Raw output" do

      let(:sth) do
        dbh = create_dummy_database
        dbh.execute "select * from numbers"
      end

      it "prints column values verbatim, semicolon-separated, to supplied IO object" do
        strio = StringIO.new

        options = double("Output")
        formatter = Formatter.new(sth, strio, options)
        formatter.output
        strio.close
        strio.string.should == "42\n"

      end

    end

  end

end