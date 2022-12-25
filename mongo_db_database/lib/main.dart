import 'package:flutter/material.dart';
import 'package:mongo_db_database/database/mongoDB.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
   MongoDatabase.instance.dbInitialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MongoDatabase mongoDatabase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mongoDatabase = MongoDatabase.instance;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
          mongoDatabase.insertOne("ayşe",45,"sdasdasdads@gmail.com");
        }, child: Text("insertOne")),
        ElevatedButton(onPressed: (){
          mongoDatabase.insertMany([]);
        }, child: Text("insertMany")),
        ElevatedButton(onPressed: (){
          mongoDatabase.updateOne("age",999);
        }, child: Text("UpdateOne")),
        ElevatedButton(onPressed: (){
          mongoDatabase.deleteOne();
        }, child: Text("deleteOne")),
        ElevatedButton(onPressed: (){
          mongoDatabase.findOne();
        }, child: Text("findOne")),
          ],
        )
      ),
    );
  }
}