import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  
  int id;
  String firstName;
  String lastName;
  ToOne<Coffe> customer = ToOne<Coffe>();

  Person({this.id = 0, required this.firstName, required this.lastName});
}


@Entity()
class Coffe {
  int id;
  String name;
  int price;
  @Backlink()
  ToMany<Person> orders = ToMany<Person>();

  Coffe({
    this.id = 0,
    required this.price,
    required this.name,
  });
}