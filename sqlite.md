# SQLite

[sqlite](https://www.sqlite.org/) is a lightweight, file-based db that is easily portable.
At the time of writing, the current version of sqlite is 3.31.1.
It is best used when you need an embedded db that will not require much by future expansion.
Examples include single user apps and games and there are several libraries to enable you to connect to a sqlite database from R, python etc.

- [Create new database](#create-new-database)
- [Create or Alter or Drop](#create-or-alter-or-drop)
  * [Create table](#create-table)
  * [Alter table](#alter-table)
  * [Drop table](#drop-table)
- [Add or Update or Delete data](#add-or-update-or-delete-data)
  * [Dates and times](#dates-and-times)
  * [Insert data from R](#insert-data-from-r)
- [Queries](#queries)
- [References](#references)

## Create new database

From the command line.

```sh
sqlite> sqlite3 test.db
```

List the `tables` defined in current db.

```sh
sqlite> .tables
```

The equivalent of `DESCRIBE` for printing the schema is 

```sh
sqlite> .schema <tablename>
```

See [here](https://sqlite.org/cli.html) for more of the CLI commands.

You can create a DB using the `RSQLite` R package.

```r
> library(DBI)
> library(RSQLite)
> mydb <- dbConnect(RSQLite::SQLite(), "test.db")
> dbDisconnect(mydb)
> unlink(mydb)
```

## Create or Alter or Drop

### Create table

If you creat a table without specifying `without rowid` then an autoincrement column call `rowid` gives a unique row id.

```sh
sqlite> sqlite3 test.db
sqlite> create table coin(
  column1 datatype PRIMARY KEY,
  column2 datatype,
  column3 datatype,
  ...
  columnN datatype
);
```

Datatypes in sqlite3 can be any of:

+ `null`
+ `integer`
+ `real`
+ `text`
+ `blob`

There is no date or time types but there are ways to handle dates and times, see [below](#dates-and-times) and [docs](https://www.sqlite.org/lang_datefunc.html).


Example (do not specify primary key), default value for price:

```sh
sqlite> CREATE TABLE gg (
  id integer,
  price real default 0,
  dt text
);
```

There is functionality to add constraints, e.g. price must be greater than zero and tokens must be unique

```sh
sqlite> CREATE TABLE temp (
  id integer,
  price real not null check(price > 0),
  token text not null unique
);
```

Insert several records.

```sh
sqlite> INSERT INTO gg(id, dt) 
  VALUES(1, datetime('now', 'localtime'));
sqlite> INSERT INTO gg(id, price, dt) 
  VALUES(1, 22, datetime('now', 'localtime'));
sqlite> INSERT INTO gg(id, price, dt) 
  VALUES(1, 22, datetime('now', 'localtime'));  
  etc...
```

show `rowid`s:

```sh
sqlite> SELECT rowid, * FROM gg WHERE price = 22;
1|1|22.0|2021-03-28 11:05:43
2|1|22.0|2021-03-28 11:10:44
3|1|22.0|2021-03-28 11:10:45
4|1|22.0|2021-03-28 11:10:45
5|1|22.0|2021-03-28 11:10:46
```

Alternatively, specify `primary key` so that `rowid` is replaced with value in `id`.
This is the preferred method.
There is no need to use `autoincrement`:
Create a table, insert some valid and invalid rows (note error) along with an demo of `id` being automatically incremented.

```sh
sqlite> CREATE TABLE hh (
  id integer primary key,
  price real,
  dt text
);
sqlite> INSERT INTO hh(id, price, dt) 
  VALUES(5, 22, datetime('now', 'localtime'));
  INSERT INTO hh(id, price, dt) 
sqlite>   
sqlite> VALUES(5, 22, datetime('now', 'localtime'));
Error: UNIQUE constraint failed: hh.id
sqlite> 
sqlite> INSERT INTO hh(id, price, dt) 
  VALUES(7, 22, datetime('now', 'localtime'));
sqlite> INSERT INTO hh(id, price, dt) 
  VALUES(8, 22, datetime('now', 'localtime'));
sqlite>   
sqlite> INSERT INTO hh(price, dt) 
  VALUES(22, datetime('now', 'localtime'));  
sqlite> SELECT rowid, * FROM hh WHERE price = 22;
5|5|22.0|2021-03-28 11:15:29
7|7|22.0|2021-03-28 11:16:06
8|8|22.0|2021-03-28 11:16:10
9|9|22.0|2021-03-28 11:17:51
```

### Alter table

You can modify tables with `alter`

```sh
sqlite> ALTER TABLE gg ADD COLUMN Age INT;
```

### Drop table

You can delete tables with `drop table <tablename>;`


## Add or Update or Delete data

Insert a new record with (colnames are optional:

```sh
sqlite> INSERT INTO Tablename(col1, col2, ...) VALUES(val1, val2, ...);
sqlite> INSERT INTO Tablename VALUES(val1, val2, ...);
```

Update with 

```sh
update <table name> set col1 = value1 where col2 = value2;
```

Example

```sh
$ sqlite3 test.db
sqlite> INSERT INTO gg(price, dt) VALUES(22, datetime('now', 'localtime'));
```

Delete

```sh
delete from <table name> where col1 = val1 and col2 = val2;
```

### Dates and times

Datetime can be stored as text, real or ints.

If you are storing as text, you can insert the current/arbitrary datetime with:

```sh
sqlite> INSERT INTO gg(price, dt) VALUES(22, datetime('now', 'localtime'));
sqlite> INSERT INTO gg(price, dt) VALUES(22, '2021-01-01 10:10:01');
```

When you have separate fields:

```sh
sqlite> CREATE TABLE gg (
  id integer PRIMARY KEY,
  price real,
  mydate text,
  mytime text  
);
sqlite> INSERT INTO gg(price, mydate, mytime) 
  VALUES(22, 
         date('now', 'localtime'), 
         time('now', 'localtime'));
sqlite> select * from gg;
1|22.0|2021-03-28|10:49:27
```

### Insert data from R

From `R` (`dbExecute` returns the number of rows added).

```r
> library(DBI)
> library(RSQLite)
> mydb <- dbConnect(RSQLite::SQLite(), "test.db")
> dbExecute(mydb, 'INSERT INTO gg(price, mydate, mytime) 
          VALUES(
          44, 
          date(\'now\', \'localtime\'), 
          time(\'now\', \'localtime\')
          )')
[1]          
```

if you have a `data.table` with dates and times stored as strings then you can create a table in one hit with:

```r
> summary(d2)
     coin               sym                 buy          
 Length:275         Length:275         Min.   :    0.00  
 Class :character   Class :character   1st Qu.:    0.22  
 Mode  :character   Mode  :character   Median :    1.14  
                                       Mean   :  748.23  
                                       3rd Qu.:    7.91  
                                       Max.   :74079.42  
                                         
    vol24               date               time          
 Length:275         Length:275         Length:275        
 Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character  
>
> dbWriteTable(mydb, "cs", d2, append = TRUE)
```

specifying `append = TRUE` will append to existing table if necessary.

## Queries

Range from select, joins, aggregation, conditioning, concatenation of fields, boolean operators, grouping.

```
sqlite> select *
  from <table name>
  where <condition>;
  
sqlite> SELECT COUNT(id) from <table name>;
sqlite> SELECT COUNT(distinct(price)) from <table name>;
```
  
See [here](https://www.guru99.com/sqlite-query.html)

## References

+ https://www.guru99.com/sqlite-tutorial.html
+ https://www.digitalocean.com/community/tutorials/sqlite-vs-mysql-vs-postgresql-a-comparison-of-relational-database-management-systems
+ https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html
+ https://www.sqlitetutorial.net/
