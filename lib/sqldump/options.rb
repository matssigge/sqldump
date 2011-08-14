module Sqldump

  class Options

    attr_accessor :database
    attr_accessor :sql

    def initialize(argv)
      self.database = argv[1]
      self.sql = "select * from #{argv[2]}"
    end

  end

end
