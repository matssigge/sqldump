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

  Scenario: pretty print
    Given a database "foo.sqlite" with a table "numbers_and_strings" with the following data
      | number[int] | string |
      | 42          | thingy |
    When I run `sqldump -d foo.sqlite -it numbers_and_strings`
    Then it should pass with:
    """
    INSERT INTO numbers_and_strings (
        number,
        string
    )
    VALUES (
        42,
        'thingy'
    );
    """

  Scenario: suppress nulls
    Given a database "foo.sqlite" with a table "numbers_and_strings" with the following data
      | number[int] | string |
      | 42          | <null> |
    When I run `sqldump -d foo.sqlite -il numbers_and_strings`
    Then it should pass with:
    """
    INSERT INTO numbers_and_strings (number) VALUES (42);
    """

  Scenario: select specific columns
    Given a database "foo.sqlite" with a table "numbers_strings_and_things" with the following data
      | number[int] | string | thing |
      | 42          | foo    | bar   |
    When I run `sqldump -d foo.sqlite -is "number,thing" numbers_strings_and_things`
    Then it should pass with:
    """
    INSERT INTO numbers_strings_and_things (number, thing) VALUES (42, 'bar');
    """
