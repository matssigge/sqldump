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

    def output_list(list)
      @io.print "\n#{indent}" if pretty
      join_string = pretty ? ",\n#{indent}" : ", "
      @io.print list.join(join_string)
      @io.print "\n" if pretty
    end

    def output_values(row)
      quoted_list = []
      row.each_with_name do |value, column_name|
        quoted_list.push quote(value, column_name)
      end
      output_list(quoted_list)
      #@io.print quoted_list.join(", ")
    end

    def cols_and_values(row)
      cols = []
      values = []
      row.each_with_name do |value, column_name|
        unless @options.suppress_nulls && value.nil?
          cols.push column_name
          values.push quote(value, column_name)
        end
      end
      [cols, values]
    end

    def output
      @sth.fetch do |row|
        (cols, values) = cols_and_values(row)
        @io.print("INSERT INTO #{@options.table} (")
        output_list(cols)
        @io.print ")"
        @io.print pretty ? "\n" : " "
        @io.print "VALUES ("
        output_list(values)
        @io.print ");\n"
      end
    end

    def quote(value, column_name)
      if value.nil?
        "NULL"
      else
        type = column_type(column_name)
        if type == DBI::Type::Integer or type == DBI::Type::Float or type == DBI::Type::Decimal
          value
        else
          value = value.to_s.gsub(/'/, "''")
          "'#{value}'"
        end
      end
    end

    def indent
      " " * 4
    end

    def pretty
      @options.pretty
    end

  end

end