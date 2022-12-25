import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:sqflite_database/model/person.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;
  DatabaseManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("person.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const boolType = "BOOLEAN NOT NULL";
    const integerType = "INTEGER NOT NULL";

    await db.execute("""
    CREATE TABLE $personTable (
      ${PersonField.id} $idType,
      ${PersonField.gender} $boolType,
      ${PersonField.age} $integerType,
      ${PersonField.name} $textType

    )

""");
  }

  Future<Person> add(Person person)async{
    final db = await instance.database;

    final id = await db.insert(personTable, person.toJson());
    return person.copy(id:id);
  }

  Future<Person> readPerson(int id) async{

    final db = await instance.database;

    final maps = await db.query(
      personTable,columns: PersonField.values,
      where: "${PersonField.id} = ?",
      whereArgs: [id], 
    );

    if(maps.isNotEmpty){
      return Person.fromJson(maps.first);
    }else{
      throw Exception("ID $id not found");
    }

  }

  Future<List<Person>> readAllPersons()async{
    final db = await instance.database;
    final orderBy = "${PersonField.age} ASC";
    //final orderBy = await db.rawQuery("SELECT * FROM $personTable ORDER BY $orderBy");

    final result = await db.query(personTable,orderBy:orderBy);

    
    return result.map((json) => Person.fromJson(json)).toList();
  }

  Future<int> update(Person person)async{

    final db = await instance.database;

    return db.update(personTable, person.toJson(),where: "${PersonField.id} = ?",whereArgs: [person.id]);

  }

  Future<int> delete(int id)async{
    final db = await instance.database;

    return await db.delete(personTable,where: "${PersonField.id} = ?",whereArgs: [id]);
  }

  Future<int> getVersion()async{
    final db = await instance.database;

    return await db.getVersion();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
