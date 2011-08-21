require 'optparse'

module Sqldump

  class Options

    attr_accessor :database
    attr_accessor :table
    attr_accessor :sql
    attr_accessor :csv_header
    attr_accessor :dump_mode

    def initialize(argv)
      optparse = OptionParser.new() do |opts|
        self.dump_mode = :csv

        opts.banner = "Usage: sqldump [options] table [extra sql]"

        opts.on_head('-h', '--help', 'Display this help.') do
          puts opts
          exit
        end

        opts.on('-d', '--database DATABASE', 'Specify the database to dump data from. In the case of file-based databases, this should be the full path of the database file.') do |database|
          self.database = database
        end

        opts.on('-i', '--insert', 'Dump data as INSERT statements.') do
          self.dump_mode = :insert
        end

        opts.on('-H', '--header', 'Include column names in csv mode.') do
          self.csv_header = true
        end
      end

      optparse.parse!(argv)

      self.table = argv[0]

      self.sql = "select * from " + argv.join(" ")
    end

  end

end
