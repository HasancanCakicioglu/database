
import 'package:firebase/Crashlytics/crashyliticsManager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class crashlyticsView extends StatefulWidget {
  crashlyticsView({Key? key}) : super(key: key);

  @override
  State<crashlyticsView> createState() => _crashlyticsViewState();
}

class _crashlyticsViewState extends State<crashlyticsView> {
  late CrashlyticsManager crashlyticsManager;

  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    crashlyticsManager = CrashlyticsManager();
    
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: SingleChildScrollView(
        child: Column(
        children: [
          ElevatedButton(onPressed: (){
            crashlyticsManager.crash();
          }, child: Text("crash")),
          ElevatedButton(onPressed: (){
            crashlyticsManager.crashDebugMode(true);
          }, child: Text("crashDebugMode")),
          ElevatedButton(onPressed: (){
            crashlyticsManager.throwError();
          }, child: Text("throw Error")),
          ElevatedButton(onPressed: (){
            crashlyticsManager.log();
          }, child: Text("log")),
          ElevatedButton(onPressed: (){
            crashlyticsManager.isCrashlyticsCollectionEnabled();
          }, child: Text("isCrashlyticsCollectionEnabled")),
          ElevatedButton(onPressed: (){
            crashlyticsManager.toggleCrashlyticsCollectionEnabled();
          }, child: Text("toggleCrashlyticsCollectionEnabled")),
          
          
        ],
      ),
      ),
    ),
    );
  }
}