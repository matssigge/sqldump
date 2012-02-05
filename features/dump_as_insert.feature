Feature: dump data as INSERT statements

  sqldump can dump data as INSERT statements so that the corresponding data can be inserted in a new database

  Scenario: simple table
    Given a database "foo.sqlite" with a table "number" with the following data
      | number[int] |
      | 42          |
    When I run `sqldump -d foo.sqlite -i number`
    Then it should pass with:
    """
    INSERT INTO number (number) VALUES (42);
    """

  Scenario: null value
    Given a database "foo.sqlite" with a table "number" with the following data
      | number[int] |
      | <null>      |
    When I run `sqldump -d foo.sqlite -i number`
    Then it should pass with:
    """
    INSERT INTO number (number) VALUES (NULL);
    """
