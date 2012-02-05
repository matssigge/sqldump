Feature: dump data from different database types (e.g. MySQL, PostgreSQL, SQLite, etc.)

  sqldump supports dumping data from any database type supported by Ruby DBI/DBD.
  The default database type is (for now) SQLite3 for the simple reason that it's extremely easy to test with.

  In a distant future, there may be JRuby support for JDBC to (possibly) extend the range of supported databases
  even further.

  Scenario: SQLite3

  Scenario: MySQL

  Scenario: SQL Server

  Scenario: PostgreSQL
    Given a PostgreSQL database named "numbers" on "localhost"
    And a table "numbers" with the following data
      | number[int] |
      | 17          |
      | 42          |
      | 4711        |
    When I run `sqldump -T postgresql -d numbers -S localhost -U mats numbers`
    Then it should pass with:
    """
    17
    42
    4711
    """
