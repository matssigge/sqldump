# SQLDump

A command line tool to dump the data in a database table as INSERT or UPDATE statements, or in CSV format.

## Installation

Just install the gem with

```bash
$ gem install sqldump
```

This will make the executable `sqldump` available from your command line.

Database access is through Ruby/DBI. DBD::SQLite3 is a direct dependency and is installed if you don't already have it. Other drivers must be installed manually. E.g.

```bash
$ gem install dbd-pg
```

**Requires Ruby 1.9.2 or later.**

## Usage

###Simplest case (SQLite3 is default). Dumps in csv format.

```bash
$ sqldump -d mydatabase.sqlite3 mytable
```

###Dump as INSERT statements

```bash
$ sqldump -d mydatabase.sqlite3 -i mytable
```

###Postgres database with username and password

```bash
$ sqldump -T pg -d mypostgresdb -U username -P password -i mytable
```

###Show all options

```bash
$ sqldump -h
```

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/matssigge/sqldump/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Mats Sigge and is under the MIT License.

## Roadmap

###Immediate goals
* Support for UPDATEs.
* Handling auto-incrementing columns, e.g. nextval('sequence_name') in PostgreSQL.
* ODBC driver to enable SQL Server.
* Ability to specify custom connection string parameters (or entire connection string).
* If possible, detecting if the specified DBD driver is installed, to give a better error message.

###Longer-term goals / pipe dreams
* Configuration system, e.g. .sqldump file
** Default user, password, host, database
* "Column handlers", e.g. some way of saying that the column CREATED_AT should get the value now() or getDate() instead of whatever value is actually in the database.
* Other hooks, e.g. being able to append `SELECT @id = @@IDENTITY` after a select on SQL Server.

###Done
* Initial support for dumping INSERTs
* Support for SQLite3
* Support for PostgreSQL
* Support for MySQL
* Pretty-printing SQL.
* Suppressing NULL columns in output.
* Selecting only some columns.


## History

Once, at a company where I worked, there was a whole lot of DB scripting. So much that I got tired of writing all that SQL by hand. At first, there were some SQL scripts that generated SQL as output, i.e. something like 

```SQL
SELECT 'INSERT INTO ' + ... 
```

but that gets tired *really quickly*. So after a while, I started hacking on a perl tool called SQLDump. It would query the database and output the results as INSERT (or UPDATE) statements directly. More and more options were added on, and it got to be quite powerful. It could take a command line like

```bash
$ sqldump -S testserver -d test_db_14 -irtl -f SPROCKET_ID RATCHET WHERE RATCHET_DATE = '2012-01-02'
```

and output

```SQL
INSERT INTO RATCHET (
	SPROCKET_ID,
	RATCHET_NAME,
	RATCHET_DATE
	CREATED_AT
)
VALUES (
	@SPROCKET_ID,
	'My ratchet rocks!',
	'2012-01-02',
	getDate()
)
```

which was pretty useful at the time. I could chain together sequences of calls and dump whole hierarchies of data. I used it a lot.

It also ended up a big smelly mess. And while it's possible to make a mess in any language, it's one of the things that Perl does best. (Don't get me wrong, I love Perl, and can't imagíne life without it, but I've also written some of my worst code in it.) So I decided that I wanted to rewrite it in Ruby, and at least attempting to keep the code clean. Also, the initial tool was specific to both SQL Server and the idiosynchracies of the system I worked on (i.e. special handling of some column names and other stuff). My vision of this rewrite is to be able to support the same kind of special handling, but through some form of hooks instead of hard coding that logic into the guts of the tool. 

Mats Sigge
