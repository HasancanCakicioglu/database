import 'package:flutter/material.dart';
import 'package:hive_database/Manager/hiveManager.dart';
import 'package:hive_database/Model/Car.dart';
import 'package:hive_database/Model/Person.dart';
import 'package:hive_database/Utility/boxEnums.dart';
import 'package:hive_database/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await HiveManager.initHiveBoxes();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: hiveView()
    );
  }
}

class araPage extends StatelessWidget {
  const araPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ara page"),),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>hiveView()));
        }, child: Text("Go")),
      ),
    );
  }
}


class hoem extends StatefulWidget {
  const hoem({Key? key}) : super(key: key);

  @override
  State<hoem> createState() => _hoemState();
}

class _hoemState extends State<hoem> {
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
      appBar: AppBar(title: Text("data"),),
      body: Container(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: Hive.box(BoxNames.personBox.name)
                  .listenable(keys: ['name', 'age']),
              builder: (context,Box box, widget) {
                final myPersonBox = box.values.toList().cast<Person>();
                return ListView.builder(itemBuilder: (context,index){
                  return Column(
                    children: [
                      Text("name:${myPersonBox[index].name} - age:${myPersonBox[index].age} - date:${myPersonBox[index].createdDate} - gender:${myPersonBox[index].gender}"),
                    ],
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}