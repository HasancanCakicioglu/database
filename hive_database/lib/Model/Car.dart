
import 'package:hive/hive.dart';
part "Car.g.dart";

@HiveType(typeId: 1)
class Car{

  @HiveField(0)
  late String model;

  @HiveField(1)
  late int price;


}