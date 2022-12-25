import 'package:flutter/material.dart';
import 'package:sqflite_database/database/databaseManager.dart';
import 'package:sqflite_database/model/person.dart';

class sqfliteView extends StatefulWidget {
  sqfliteView({Key? key}) : super(key: key);

  @override
  State<sqfliteView> createState() => _sqfliteViewState();
}

class _sqfliteViewState extends State<sqfliteView> {
  late DatabaseManager databaseManager;
  late List<Person> personlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseManager  = DatabaseManager.instance;
    initPerson();
  }

  void initPerson()async{
    personlist.addAll(await databaseManager.readAllPersons());
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: personlist.length,
              itemBuilder: (context,index){
              return ListTile(
                title: Text(personlist[index].name),
                leading: IconButton(onPressed: (){
                  databaseManager.delete(personlist[index].id!);
                  setState(() {
                  personlist.removeWhere((element) => element.id ==personlist[index].id);
                });}, icon: const Icon(Icons.delete)),
                trailing: Text(personlist[index].id.toString()),
              );
            }),
            ElevatedButton(onPressed: ()async{
              Person person = Person(name: "fatma", age: 111, gender:false);
              databaseManager.add(person).then((Person value){
                setState(() { 
                  personlist.add(value);
                  print("setState");
                });
              });
              
            }, child: const Text("addPerson")),
            ElevatedButton(onPressed: (){
              databaseManager.update(Person(id: 1,name: "mehmet", age: 999, gender: true));
              setState(() {
                
              });
            }, child: const Text("update")),
            ElevatedButton(onPressed: (){
              debugPrint(databaseManager.readPerson(1).toString());
              setState(() {
                
              });
            }, child: const Text("read")),
            ElevatedButton(onPressed: ()async{
              databaseManager.getVersion().then((value) => debugPrint(value.toString()));
              
            }, child: const Text("getVersion")),

            ElevatedButton(onPressed: (){
              databaseManager.close();
              
            }, child: const Text("close")),
          ],
        ),
      ),
    );
  }
}