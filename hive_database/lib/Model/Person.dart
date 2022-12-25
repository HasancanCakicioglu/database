

import 'package:hive/hive.dart';
part "Person.g.dart";

@HiveType(typeId: 0)
class Person extends HiveObject{

  Person({required this.name,this.age=10,required this.createdDate,this.gender});

  @HiveField(0,defaultValue: "defaultName")
  late String name;

  @HiveField(1,defaultValue: 100)
  int age;

  @HiveField(2,defaultValue: false)
  bool? gender;

  @HiveField(3)
  late DateTime createdDate;

}