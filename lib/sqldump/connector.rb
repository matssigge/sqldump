require 'dbi'

module Sqldump

  class Connector

    def initialize(options)
      @options = options
    end

    def connect
      begin
        dbh = DBI.connect(get_url)
        yield dbh

      ensure
        dbh.disconnect if dbh
      end

    end

    def get_url
      database = @options.database
      "DBI:SQLite3:#{database}"
    end

  end

end
