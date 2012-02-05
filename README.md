# SQLDump

A command line tool to dump the data in a database table as INSERT or UPDATE statements, or in CSV format.

## Installation

Just install the gem with

`gem install sqldump`

This will make the executable `sqldump` available from your command line.

**Requires Ruby 1.9.2 or later.**

## Usage

###Simplest case (SQLite3 is default). Dumps in csv format.

`sqldump -d mydatabase.sqlite3 mytable`

###Dump as INSERT statements

`sqldump -d mydatabase.sqlite3 -i mytable`

###Postgres database with username and password

`sqldump -T pg -d mypostgresdb -U username -P password -i mytable`

###Show all options

`sqldump -h`


## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/matssigge/sqldump/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Mats Sigge and is under the MIT License.