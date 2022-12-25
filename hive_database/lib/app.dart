

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_database/Manager/hiveManager.dart';

import 'package:hive_database/Model/Person.dart';
import 'package:hive_database/Utility/boxEnums.dart';
import 'package:hive_flutter/hive_flutter.dart';

class hiveView extends StatefulWidget {
  hiveView({Key? key}) : super(key: key);

  @override
  State<hiveView> createState() => _hiveViewState();
}

class _hiveViewState extends State<hiveView> {
  late HiveManager hiveManager;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiveManager = HiveManager();
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
          //  StreamBuilder<BoxEvent>(
          //     stream: hiveManager.watchPerson().cast(),
          //     builder: (context,snapshot){
          //     var gelenSnap = snapshot as List<Box<Person>>;
          //     return Text("watch ${gelenSnap.last.name}");
          //   }),
           ValueListenableBuilder<Box<Person>>(
              valueListenable: Hive.box<Person>(BoxNames.personBox.name)
                  .listenable(),
              builder: (context, box, widget) {
                if(box.values.isEmpty){
                  return const Center(child: CircularProgressIndicator(),);
                }
                final myPersonBox = box.values.toList().cast<Person>();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: myPersonBox.length,
                  itemBuilder: (context,index){
                  return Column(
                    
                    children: [
                      Text("name:${myPersonBox[index].name} - age:${myPersonBox[index].age} - date:${myPersonBox[index].createdDate} - gender:${myPersonBox[index].gender}"),
                    ],
                  );
                });
              },
            ),
            ElevatedButton(onPressed: (){
              hiveManager.addPerson(Person(name: "FFG",age: 1,createdDate: DateTime.now()));
            }, child: Text("addPerson")),
            ElevatedButton(onPressed: (){
              hiveManager.clearBox(BoxNames.personBox);
            }, child: Text("clearBox")),
            ElevatedButton(onPressed: (){
              hiveManager.flush();
            }, child: Text("flush")),
            ElevatedButton(onPressed: (){
              hiveManager.getPerson("0");
            }, child: Text("getPerson")),
            ElevatedButton(onPressed: (){
              hiveManager.normalPut("keyim","valuem");
            }, child: Text("normalPut")),
            ElevatedButton(onPressed: (){
              hiveManager.closeBox(BoxNames.personBox.name);
            }, child: Text("closeBox")),
            ElevatedButton(onPressed: (){
              hiveManager.deleteFromDisk();
            }, child: Text("deleteFromDisk")),
            
            
          ],
        ),
      ),
    );
  }
}
