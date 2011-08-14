require 'sqldump'
require 'dbi'

class Object

  def create_dummy_database(database = '/tmp/foo.sqlite')
    File.delete(database) if File.exists?(database)

    dbh = DBI.connect("DBI:SQLite3:#{database}")
    dbh.do("CREATE TABLE numbers (number int);")
    dbh.do("INSERT INTO numbers (number) VALUES (42);")
    dbh
  end

end
