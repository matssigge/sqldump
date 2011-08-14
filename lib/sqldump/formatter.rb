module Sqldump

  class Formatter

    def initialize(sth, io, options)
      @sth = sth
      @io = io
      @options = options
    end

    def output
      @sth.fetch do |row|
        @io.puts row.join ";"
      end
    end
  end

end