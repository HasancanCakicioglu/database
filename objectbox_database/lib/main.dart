
import 'package:faker/faker.dart' hide Person;
import 'package:flutter/material.dart';
import 'package:objectbox_database/model/person.dart';
import 'package:objectbox_database/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';



Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final faker = Faker();
  List<Person> listPerson= [];
  late Stream<List<Person>> _stream;

  late Store _store;
  bool hasBeenInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        // This method is from the generated file
        getObjectBoxModel(),
        directory: ["${dir.path}","objectbox"].join(""),
      );

      setState(() {
        _stream = _store
            .box<Person>()
            // The simplest possible query that just gets ALL the data out of the Box
            .query()
            .watch(triggerImmediately: true)
            // Watching the query produces a Stream<Query<ShopOrder>>
            // To get the actual data inside a List<ShopOrder>, we need to call find() on the query
            .map((query) => query.find());

        hasBeenInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _store.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            !hasBeenInitialized
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<List<Person>>(
              stream: _stream,
              builder: (context,AsyncSnapshot<List<Person>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                    return ListTile(
                      title: Text("${snapshot.data![index].firstName} - ${snapshot.data![index].customer}"),
                      leading: Text(snapshot.data![index].id.toString()),
                      trailing: IconButton(onPressed: (){
                        _store.box<Person>().remove(snapshot.data![index].id);
                      }, icon: const Icon(Icons.delete)),
                    );
                  });
                }
              },
            ),
    
            ElevatedButton(onPressed: (){
              final person = Person(
                firstName: faker.person.name(),
                lastName: faker.person.lastName(),

              );

              int id = _store.box<Person>().put(person);
              listPerson.add(person..id=id);
            }, child: Text("Add")),
            ElevatedButton(onPressed: (){
              _store.box<Person>().removeAll();
            }, child: Text("removeAll")),
            ElevatedButton(onPressed: (){
              debugPrint(_store.box<Person>().contains(2).toString());
            }, child: Text("contains index 2")),
            ElevatedButton(onPressed: (){
               debugPrint("limit 0 = "+_store.box<Person>().count().toString());
              debugPrint("limit 2 = "+_store.box<Person>().count(limit: 2).toString());
            }, child: Text("count limit 2")),
            ElevatedButton(onPressed: (){
               
              
            }, child: Text("query")),
            ElevatedButton(onPressed: (){
               
              
            }, child: Text("query")),
          ],
        ),
      ),
    );
  }
}