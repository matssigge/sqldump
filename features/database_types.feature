Feature: dump data from different database types (e.g. MySQL, PostgreSQL, SQLite, etc.)

  sqldump supports dumping data from any database type supported by Ruby DBI/DBD.
  The default database type is (for now) SQLite3 for the simple reason that it's extremely easy to test with.

  In a distant future, there may be JRuby support for JDBC to (possibly) extend the range of supported databases
  even further.

  Scenario: SQLite3

  Scenario: MySQL

  Scenario: PostgreSQL
