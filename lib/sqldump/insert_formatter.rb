module Sqldump

  class InsertFormatter

    def initialize(sth, io, options)
      @sth = sth
      @io = io
      @options = options

      setup_column_type_mapping()
    end

    def setup_column_type_mapping
      @column_type_by_name = Hash[@sth.column_names.zip(@sth.column_types)]
    end

    def column_type(column_name)
      @column_type_by_name[column_name]
    end

    def output_column_names
      @io.print @sth.column_names.join(", ")
    end

    def output_values(row)
      quoted_list = []
      row.each_with_name do |value, column_name|
        quoted_list.push quote(value, column_name)
      end
      @io.print quoted_list.join(", ")
    end

    def output
      @sth.fetch do |row|
        @io.print("INSERT INTO #{@options.table} (")
        output_column_names()
        @io.print ") VALUES ("
        output_values(row)
        @io.print ");\n"
      end
    end

    def quote(value, column_name)
      type = column_type(column_name)
      if type == DBI::Type::Integer or type == DBI::Type::Float or type == DBI::Type::Decimal
        value
      else
        value = value.to_s.gsub(/'/, "''")
        "'#{value}'"
      end
    end

  end

end