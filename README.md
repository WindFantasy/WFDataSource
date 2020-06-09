# WFDataSource - For Doing SQLite Things Easier.

WFDataSource is a solution for doing SQLite. It allows you to bind methods of `protocols` to SQL statements. 


# Table of Content
- [Design Phylosophy](#design-phylosophy)
- [Installation](#installation)
- [Example of Usage](#example-of-usage)
- [Concepts](#concepts)
	- [Types And Values](#types-and-values)
	- [Operations](#operations)
	- [SQL Parameter And Binding Parameter](#sql-parameter-and-binding-parameter)
- [Create an Connection](#create-an-connection)
- [Data Access Object](#data-access-object)
	- [DAO Script](#dao-script)
	- [DAO Protocol](#dao-protocol)
	- [Instantiate DAO](#instantiate-dao)
	- [DAO Operations](#dao-operations)
		- [Insert Operation](#insert-operation)
		- [Delete Operation](#delete-operation)
		- [Update Operation](#update-operation)
		- [Select Operation (with Primary Result)](#select-operation-with-primary-result)
		- [Select Operation (with Entity Result)](#select-operation-with-entity-result)
- [SQL Stream](#sql-stream)
- [License](#license)

# Design Phylosophy

WFDataSource is NOT a toolkit. It does not provide rich features to customize how to handle SQLite. Instead WFDataSource is a solution. It helps you to handle SQLite with certain routines. Therefore, WFDataSource supports very limited SQLite features. However, it is sufficient to make an iOS app. Cut off those not necessory so that focus on those used most frequetly. Less is sometimes the best.

# Installation

```ruby
pod 'WFDataSource', :git => 'https://github.com/WindFantasy/WFDataSource.git'
```

# Example of Usage

**Define a `.dao.xml` script (*employee.dao.xml*)**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<dao>
    <insert selector="insert:" table="employee"/>
    <select selector="selectAll" type="EmployeeEntity"><![CDATA[
        SELECT * FROM employee
    ]]></select>
...
</dao>
```

**Define an Objective-C Protocol (*EmployeeDao*)**

```objc
@protocol EmployeeDao <NSObject>
-(NSInteger)insert:(EmployeeEntity *)entity;
-(NSArray<EmployeeEntity *> *)selectAll;
...
@end
```

**Do DB things**

```objc
WFDSConnection *connection = [WFDSConnection connectionWithDocumentPath:@"main.sqlite"];
id<EmployeeDao> dao = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:connection script:@"employee" protocol:@protocol(EmployeeDao)];

EmployeeEntity *entity = [[EmployeeEntity alloc] init];
entity.eid = ...

[dao insert:entity];
...

NSArray<EmployeeEntity *> *employees = [dao selectAll];
```

# Concepts


`WFDataSource` hides the low level SQL interaction (eg. *Statement* and *Result Set* ...) from users. `WFDataSource` try to make things as simple as working with native ObjC object. However, certain concepts need to be know before using `WFDataSource`. 

## Types And Values

WFDataSource not going to compatible to all data types. It support the followings. 

| SQLite Type | Objective-C Type | NULL Value | Comment |
|---|---|---|---|
| `INTEGER` | `NSInteger`, `BOOL` | `0`, `NO` |  |
| `FLOAT` | `double` | `0.0` |  |
| `TEXT` | `NSString *` | `nil` |  |
| `DATETIME` | `NSDate *` | `nil` | Stored as double, which represents the number of seconds from *Reference-date* (00:00:00 UTC on 1 January 2001).  |

Some more restrictions:

### NO Type Alias

SQLite supports type alias that allows to use different type names to represent a data type. However, behaviors of using type alias in WFDataSource are not defined. Columns should be defined by using the exact type names from the above table. 

### NO Dynamic Typing

SQLite supports dynamic typing, which the actual data type is depended on how you are going to read the value NOT how you defined the type of the value. 
For example, a `TEXT` column, could also read as `INTEGER` or `FLOAT`. It depended on how read it and whether it could be parsed to the targeted type. 
WFDataSource assume users do static-typping. Values MUST stay as how the column were defined. Behaviors of dynamic typing are not defined. 

### NO BLOBs

WFDataSource does not support `BLOB` data type. It because we cannot find any use case we MUST us BLOBs during app developments. There is always supplemental solutions and often better than store binary data directly in database.  

### NULLs

NULLs to WFDataSource is different to SQLite. WFDataSource converts NULLs to non-null values for C primary types. Generally speaking they are converted to zero-values.

## Operations

There are two types of operations the *Update Operations* and the *Query Operations*.

### Update Operations 

Include `<insert>`, `<delete>` and `<update>`, which may modify the data. Selector of *Update Operations* MUST returns a `NSInteger` to indicate the update count of the operation.

### Query Operations 

Include `<select>`, which just query data. *Query Operations* are not going to modify any data. They may return primary types, which including `BOOL`, `NSInteger`, `double`, `NSString *` and `NSDate *`. They also return either a single *Value Object* or an array of *Value Objects*. An *Value Object* is also called an *Entity*, which its properties represent the value of columns and the *Entity* as a whole represents a column of the table.

## SQL Parameter And Binding Parameter 

A *Prepared Statement* basically is a precompiled statement object so that avoid to compile SQL during execution time. Another key feature is *Prepared Statement* allows to execut with parameters. It let you to reuse a SQL structure by filling different parameter so that no need to rewrite the SQL because some of the values were changed.

There two ways label a parameter in SQLite. The *Quetion Mark Notation* and the *Colon Notation*

### Quetion Mark Notation `?`

*Quetion Mark Notation* handle parameters according to their native order.

```sql
SELECT ? + ?
```

When pass 1 and 2 to the *Prepared Statement*, it will substute 1 and 2 to the `?` in order. The execution will return 3 as result.

```sql
SELECT (?2 - ?1) / ?1
```

We could also label a `?` with the order of the parameter. When we pass 4 and 6 to the *Prepared Statement*, it will substute 4 and 6 to the `?`s according to order of the parameters. The execution will return 0.5 as result. 

**NOTE**: Order of parameter counts from 1 (Not 0).

In WFDataSource *Quetion Mark Notation* SQL only works with primary types (`BOOL`, `NSInteger`, `double`, `NSString *` and `NSDate *`). 

### Colon Notation `:`

*Colon Notation* handle parameters according to their names. 

```sql
SELECT :eid, :firstName, :lastName
```
When We pass Strings 'eid-0001', 'Jerry' and 'Huang' with names 'eid', 'firstName' and 'lastName' respectively to the *Prepared Statement*, it will substute the values to the `:` tokens according to their names. The execution will return a result set with 3 columns, which the values are 'eid-0001', 'Jerry', 'Huang'.

In WFDataSource *Colon Notation* SQL works with *Entity* parameter. WFDataSource treat properties of *Entity* as parameters and bind them to the statement according to the names of the properties.

**NOTE**: Selector of *Colon Notation* base operation always has only ONE explict parameter, which is an *Entity*.

# Create an Connection

To using `WFDataSource`, first we need to create a connection to the database.

```objc
WFDSConnection *connection = [WFDSConnection connectionWithDocumentPath:@"main.sqlite"];
```

WFDConnection is a class represents connection to SQLite database. Above is how you might create a database connection. It will look for a database named *main.sqlite* under the document directory (specifiied by `NSDocumentDirectory`). Database will be created automatically if not exist.

# Data Access Object

A Data Access Object (DAO) is a object instance for handling database. Basically it handles the following tasks:

- Binds parameters to SQL statement.
- Executes SQL.
- Convert query result to Object instance.

To create a DAO you need: a DAO script, a DAO protocol.

## DAO Script

A DAO script is a xml-base script, whose file extension is `.dao.xml`. DAO script MUST located in main bundle. It is where you write your SQL and define the selector it binds to. 

A DAO script begins with a pair of `<dao>` tags and with operation tags in between. A typical example would be something like this: 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<dao>
    <insert selector="insert:" table="employee"/>
    <select selector="selectAll" type="EmployeeEntity"><![CDATA[
    SELECT * FROM employee
    ]]></select>
...
</dao>
```
Operation tags include `<insert>`, `<delete>`, `<update>` and `<select>`. Operation tag has the following xml components:

| Component | XML Type | Required | Description |
|---|---|---|---|
| CDATA block | Component | true | Where to write the statement. |
| selector | Attribute | true | A string attribute to specify the selector of DAO that the operation going to bind with. |
| trace | Attribute | false | A boolean attribute specify whether print the trace log to console when the operation is invoked. For Debug purpose. |

## DAO Protocol

A DAO Protocol is an Objective-C protocol that going to bind with a DAO script. It is the interface to access the DAO operations. A DAO protocol would be something like this:
```objc
@protocol EmployeeDao <NSObject>
-(NSInteger)insert:(EmployeeEntity *)entity;
-(NSArray<EmployeeEntity *> *)selectAll;
...
@end
```

## Instantiate DAO

To create a DAO instance, you should do something like this:

```objc
id<EmployeeDao> dao = [WFDSDaoManager.sharedManager instantiateDaoWithConnection:connection script:@"employee" protocol:@protocol(EmployeeDao)];
```

The above creates a DAO instance confirm to protocol `EmployeeDao` according to its DAO Script `employee.dao.xml`.

## DAO Operations 

### Insert Operation

#### Protocol Selector

```objc
-(NSInteger)insert:(EmployeeEntity *)entity;
```

#### Script

```xml
<insert selector="insert:"><![CDATA[
    INSERT INTO employee (eid, first_name, last_name, dob ...)
    VALUES (:eid, :firstName, :lastName, :dob ...)
]]></insert>
```

Insert statements are often of format `INSERT INTO talbe (...) VALUES (...)` , It is long-winded for tables with many columns. A shortcut would make things elegant. WFDataSource could automatically build an insertion SQL according to a table schema. 

The following code block will build insert SQL by using all the columns defined by the 'employee' table except 'salary' and 'position'.

```xml
<insert selector="insert:"
    exclude="salary, position"
    table="employee"/>
```
| Attribute | Description |
| --- | --- |
| `table` | The name of table schema for the auto-build SQL base on. |
| `exclude` | The columns excluded from the auto-build SQL. Separate with commas ',' for multiple columns. |

### Delete Operation

#### Protocol Selector

```objc
-(NSInteger)deleteWithEid:(NSString *)eid;
```

#### Script

```xml
<delete selector="deleteWithEid:"><![CDATA[
    DELETE FROM employee
    WHERE eid=?
]]></delete>
```
### Update Operation

#### Protocol Selector

```objc
-(NSInteger)update:(EmployeeEntity *)entity;
```

#### Script

```xml
<update selector="update:"><![CDATA[
    UPDATE employee SET
        salary=:salary,
        position=:position,
        ...
    WHERE eid=:eid
]]></update>
```

Just like insertion statements, update statements are often structurely fixed. A shortcut is available to update operations.


The following code block will build a update SQL by using all the columns defined by the 'employee' table except 'first_name', 'last_name' and 'dob'. The update takes place where `eid=:eid`

```xml
<update selector="update:"
    exclude="first_name, last_name, dob"
    table="employee"
    where="eid=:eid"/>
```
| Attribute | Description |
| --- | --- |
| `table` | The name of table schema for the auto-build SQL base on. |
| `exclude` | The columns excluded from the auto-build SQL. Separate with commas ',' for multiple columns. |
| `where` | The `WHERE` statement component, which restrict where the update should take place. |

### Select Operation (with Primary Result)

#### Protocol Selector

```objc
-(BOOL)selectBoolean;
-(NSInteger)selectInteger;
-(double)selectDouble;
-(NSString *)selectString;
-(NSDate *)selectDate;
```

#### Script

```xml
<select selector="selectBoolean"><![CDATA[
    SELECT 1
]]></select>
<select selector="selectInteger"><![CDATA[
    SELECT 1024
]]></select>
<select selector="selectDouble"><![CDATA[
    SELECT 3.14
]]></select>
<select selector="selectString"><![CDATA[
    SELECT 'Hello World'
]]></select>
<select selector="selectDate"><![CDATA[
    SELECT strftime('%s', '2002-02-20 00:00:00') - strftime('%s', '2001-01-01 00:00:00')
]]></select>
```

Handling primary types is very straight forward. WFDataSource will read the result according to the return type of the selector. You MUST make sure the SQL returns excatly one row one column.

If the SQL returns multiple rows of one column primary. Try to Handle it with *Entity*. Define an *Entity* with general query purpose is useful in this case.

### Select Operation (with Entity Result)

#### Protocol Selector

```objc
-(EmployeeEntity *)selectWithEid:(NSString *)eid;
-(NSArray<EmployeeEntity *> *)selectAll;
```

#### Script

```xml
<select selector="selectWithEid:" type="@EmployeeEntity"><![CDATA[
    SELECT * FROM employee
    WHERE eid=:eid
]]></select>
<select selector="selectAll" type="EmployeeEntity"><![CDATA[
    SELECT * FROM employee
]]></select>
```

WFDataSource set the *Entity*'s properties if the property/column exist in both the *Entity* and the query result set.


| Attribute | Description |
| --- | --- |
| `type` | An Objective-C class name. Indicate what *Entity* type should the result set convert to. The result set will be converted to an array of instance of the specified class. If the value has a leading '@' notation, then the result set will be converted an instance of the specified class (Make sure the result set contains excatly one row). |

## SQL Stream

During pratical app development, database data and structure may changed version by version. `WFDatatSource` provides a solution to process batches of SQLs. It called SQL stream processing. When you need to change the data or structure, create a new SQL stream file, put whatever changes you want to make, then `WFDatatSource` handle the rest for you.

- A SQL Stream is a batch of SQLs stored in a `.stream.xml` in the app main bundle. SQL stream file MUST named with numbers, eg. 01.stream.xml, 02.stream.xml ... (the prefix 0s are optional). The number is the version of that particular file. 
- Typical `.stream.xml` files look like these: [01.stream.xml](WFDataSourceDemo/Resource/DBStream/01.stream.xml), [02.stream.xml](WFDataSourceDemo/Resource/DBStream/02.stream.xml). Basically they are collections of SQLs wrritten in xml format.
- Invoke `[WFDSConnection processSQLStreamInMainBundle]` in your app to process streams. Streams are processed in order. `WFDataSource` maintains a stream version for the database. Every time finish a stream the stream version of the database is updated. Any stream that its version lower or equal to the stream version of the database would not be processed. 

NOTE: SQLs in a stream are executed inside a begin-commit block. Any catch of exception during the process will cause rollback. You MUST NOT do commit-related SQLs in stream.

# License

MIT licensed - see [LICENSE](LICENSE) file.
