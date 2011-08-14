Feature: dump raw data

  As a command-line user
  I want to dump raw data from a table in a database to STDOUT
  So that I can easily access data in any database

  @announce
  Scenario: one-column, one-row table
    Given a database "foo.sqlite" with a table "numbers" with the following data
      | number[int] |
      | 42          |
    When I run `sqldump -d foo.sqlite numbers`
    Then it should pass with:
    """
    42
    """

#  Scenario: multi-row table
#    Given a database "/tmp/foo.sqlite" with a table "numbers" with the following data
#      | number[int] |
#      | 17          |
#      | 42          |
#      | 4711        |
#    When I run `sqldump -d /tmp/foo.sqlite numbers`
#    Then it should pass with:
#    """
#    17
#    42
#    4711
#    """

