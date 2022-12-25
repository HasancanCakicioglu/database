
final String personTable = "persons";
class PersonField{

  static final List<String> values = [id,name,age,gender];

  static const String id = "_id";
  static const String name = "name";
  static const String age = "age";
  static const String gender= "gender";

}


class Person{
  Person({required this.name,required this.age,required this.gender,this.id});

  int? id;
  String name;
  int age;
  bool gender;

  static Person fromJson(Map<String,Object?> json)=>
  Person(
    id: json[PersonField.id] as int,
    name:json[PersonField.name] as String,
   age: json[PersonField.age] as int,
    gender: json[PersonField.gender]==1);

  Map<String,Object?> toJson()=>{

    PersonField.id:id,
    PersonField.name:name,
    PersonField.age:age,
    PersonField.gender:gender ? 1 : 0,

  };

  Person copy({int? id,String? name,int? age,bool? gender})
  =>Person(
    id: id ?? this.id,
    name: name ?? this.name, age: age ?? this.age, gender: gender ?? this.gender);


}