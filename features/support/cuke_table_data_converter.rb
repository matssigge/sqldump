class CukeTableDataConverter

  def initialize(table_name, table)
    @table_name = table_name
    @table = table

    @column_names = extract_column_names(table)
    @datatypes = extract_column_datatypes(table)
  end

  def extract_column_names(table)
    table.column_names.collect { |column| column_name(column) }
  end

  def extract_column_datatypes(table)
    datatypes = Hash.new
    table.column_names.each do |column|
      datatype = column_datatype(column)
      datatypes[column_name(column)] = datatype
    end
    datatypes
  end

  def get_create_table_sql
    query = "CREATE TABLE #{@table_name} ("
    query += @column_names.collect { |column| "#{column} #{@datatypes[column]}" }.join ", "
    query += ");"
    query
  end

  def get_insert_sql
    sql = []
    @table.hashes.each do |hash|
      query = "INSERT INTO #{@table_name} ("
      query += @column_names.join ", "
      query += ") VALUES ("
      query += @table.column_names.collect { |column| as_sql_literal(hash[column]) }.join ", "
      query += ");"
      sql << query
    end
    sql
  end

  def as_sql_literal(value)
    if value == '<null>'
      'NULL'
    elsif (value =~ /[^0-9]/ || value =~ /^0./)
      "'#{value}'"
    else
      value
    end
  end

  def column_name(column_heading)
    /^(\w+)/.match(column_heading)[1]
  end

  def column_datatype(column_heading)
    column_heading =~ /\[([^\]]+)\]/ ? $1 : 'varchar(100)'
  end

end
