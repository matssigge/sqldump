module Sqldump

  class RawFormatter

    def initialize(sth, io, options)
      @sth = sth
      @io = io
      @options = options
    end

    def output
      if @options.csv_header
        @io.puts @sth.column_names.join(",")
      end
      @sth.fetch do |row|
        @io.puts row.join(",")
      end
    end
  end

end
