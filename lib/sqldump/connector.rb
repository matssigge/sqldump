require 'dbi'

module Sqldump

  class Connector

    def initialize(options)
      @options = options
    end

    def connect
      begin
        dbh = DBI.connect(get_url, get_user, get_password)
        yield dbh

      ensure
        dbh.disconnect if dbh
      end

    end

    def get_url
      database = @options.database
      driver = get_driver
      "DBI:#{driver}:#{database}"
    end

    def get_driver
      case @options.database_type
        when :sqlite3
          "SQLite3"
        when :postgresql
          "Pg"
      end
    end

    def get_user
      @options.username
    end

    def get_password
      @options.password
    end

  end

end
