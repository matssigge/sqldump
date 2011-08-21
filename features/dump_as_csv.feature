Feature: dump as csv

  The default mode of operation of sqldump is to output data in CSV

  Scenario: one-column, one-row table
    Given a database "foo.sqlite" with a table "number" with the following data
      | number[int] |
      | 42          |
    When I run `sqldump -d foo.sqlite number`
    Then it should pass with:
    """
    42
    """

  Scenario: multi-row table
    Given a database "foo.sqlite" with a table "numbers" with the following data
      | number[int] |
      | 17          |
      | 42          |
      | 4711        |
    When I run `sqldump -d foo.sqlite numbers`
    Then it should pass with:
    """
    17
    42
    4711
    """

  Scenario: multi-column table
    Given a database "foo.sqlite" with a table "numbers_and_strings" with the following data
      | number[int] | string |
      | 17          | foo    |
      | 42          | bar    |
      | 4711        | baz    |
    When I run `sqldump -d foo.sqlite numbers_and_strings`
    Then it should pass with:
    """
    17,foo
    42,bar
    4711,baz
    """

  Scenario: with header line
    Given a database "foo.sqlite" with a table "numbers_strings_and_things" with the following data
      | number[int] | string | thing       |
      | 17          | foo    | rubber duck |
    When I run `sqldump -d foo.sqlite -H numbers_strings_and_things`
    Then it should pass with:
    """
    number,string,thing
    17,foo,rubber duck
    """

  Scenario: custom separator

  Scenario: quoting of separator
