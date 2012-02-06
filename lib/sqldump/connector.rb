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
      driver = get_driver
      url = "DBI:#{driver}:#{@options.database}"
      if use_host
        url += ":#{@options.host}"
      end
      url
    end

    def get_driver
      case @options.database_type
        when :sqlite3
          "SQLite3"
        when :postgresql
          "Pg"
        when :mysql
          "Mysql"
        else
          raise "Unknown database type " + @options.database_type
      end
    end

    def use_host
      @options.database_type != :sqlite3
    end

    def get_user
      @options.username
    end

    def get_password
      @options.password
    end

  end

end
