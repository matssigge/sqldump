module Sqldump

  class Dumper

    def initialize(dbh, options)
      @dbh = dbh
      @options = options
    end

    def dump
      begin
        sth = @dbh.execute(@options.sql)
        yield sth

      ensure
        sth.finish if sth

      end
    end

  end

end
