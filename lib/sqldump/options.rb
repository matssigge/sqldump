require 'optparse'

module Sqldump

  class Options

    SUPPORTED_DATABASES = ['postgresql', 'mysql', 'sqlite3']

    attr_accessor :database
    attr_accessor :host
    attr_accessor :username
    attr_accessor :password
    attr_accessor :database_type
    attr_accessor :table
    attr_accessor :sql
    attr_accessor :csv_header
    attr_accessor :dump_mode
    attr_accessor :pretty

    def initialize(argv)
      parse_options(argv)

      set_derived_options(argv)
    end

    def set_derived_options(argv)
      self.table = argv[0]

      self.sql = "select * from " + argv.join(" ")
    end

    def parse_options(argv)
      optparse = define_options()
      optparse.parse!(argv)
      if argv.size == 0
        print optparse
        exit
      end
    end

    def setup_defaults
      self.dump_mode = :csv
      self.database_type = :sqlite3
      self.host = 'localhost'
    end

    def define_options
      optparse = OptionParser.new do |opts|
        setup_defaults()

        opts.banner = "Usage: sqldump [options] table [extra sql]"

        opts.on_head('-h', '--help', 'Display this help.') do
          puts opts
          exit
        end

        # TODO: Handle line wrapping in description
        opts.on('-d', '--database DATABASE', "Specify the database to dump data from. In the case of file-based databases, this should be the full path of the database file.") do |database|
          self.database = database
        end

        opts.on('-S', '--host USER', 'Specifies the host where the database is located, if applicable. If not specified, the default host is localhost.') do |host|
          self.host = host
        end

        opts.on('-U', '--username USER', 'Specifies the username to use') do |username|
          self.username = username
        end

        opts.on('-P', '--password PASSWORD', 'Specifies the password to use') do |password|
          self.password = password
        end

        opts.on('-T', '--dbtype TYPE', 'Specify the type of database to connect to. Supported types are sqlite3, postgresql/pg.') do |type|
          type.downcase!
          type = 'postgresql' if type == 'pg'
          unless SUPPORTED_DATABASES.include?(type)
            puts "Unsupported database type #{type}"
            exit
          end
          self.database_type = type.to_sym
        end

        opts.on('-i', '--insert', 'Dump data as INSERT statements.') do
          self.dump_mode = :insert
        end

        opts.on('-t', '--pretty', 'Pretty-print SQL output (i.e. columns on separate lines, indentation).') do
          self.pretty = true
        end

        opts.on('-H', '--header', 'Include column names in csv mode.') do
          self.csv_header = true
        end
      end
      optparse
    end

  end

end
