import 'package:flutter/material.dart';
import 'package:hive_database/Model/Car.dart';
import 'package:hive_database/Model/Person.dart';
import 'package:hive_database/Utility/boxEnums.dart';
import 'package:hive_flutter/adapters.dart';

class HiveManager {
  static late final personBox = Hive.box<Person>("personBox");
  static late final carBox = Hive.box<Car>("carBox");
  static late final normalBox = Hive.box("normalBox");

  static Future<void> initHiveBoxes() async {
    Hive.registerAdapter(PersonAdapter());
    await Hive.openBox<Person>("personBox");

    Hive.registerAdapter(CarAdapter());
    await Hive.openBox<Car>("carBox");

    await Hive.openBox('normalBox'); //class'I yok
  }

  void closeBox(String boxName) {
    Hive.box(boxName).close();
  }

  Future<void> addPerson(Person person) async {
   await personBox.add(person);
  }
  Future<void> getPerson(String key) async {
    Person defaultValue = Person(name: "default",age: 0,createdDate: DateTime.now());
    debugPrint(personBox.get(key,defaultValue: defaultValue)?.name.toString());
  }
  Future<void> clearBox(BoxNames boxname) async {
    await Hive.box(boxname.name).clear();
  }
  Future<void> deleteKey(String key) async {
    await personBox.delete(key);
  }
  Future<void> normalPut(String key,dynamic value) async {
    await Hive.box("normalBox").put(key,value);
  }

  
  Future<void> flush() async {
    await personBox.flush();
  }
  Future<void> deleteFromDisk() async {
    await personBox.deleteFromDisk();
  }

  Stream watchPerson()  {
    return Hive.box("personBox").watch();
  }

  void compactBox(){
    personBox.compact();//klasörü sıkıştırır
  }
}
