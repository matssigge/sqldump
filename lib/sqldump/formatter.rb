require 'sqldump/raw_formatter'
require 'sqldump/insert_formatter'

module Sqldump

  class Formatter

    private_class_method :new

    def self.formatter(sth, io, options)
      case options.dump_mode
        when :csv   then RawFormatter.new(sth, io, options)
        when :insert then InsertFormatter.new(sth, io, options)
      end
    end

  end

end