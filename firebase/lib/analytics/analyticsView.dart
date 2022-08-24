
import 'package:firebase/analytics/anayliyticManager.dart';
import 'package:flutter/material.dart';

class firebaseAnalytcisView extends StatefulWidget {
  firebaseAnalytcisView({Key? key}) : super(key: key);

  @override
  State<firebaseAnalytcisView> createState() => _firebaseAnalytcisViewState();
}

class _firebaseAnalytcisViewState extends State<firebaseAnalytcisView> {

  late AnalytsicsManager analytsicsManager;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytsicsManager = AnalytsicsManager();
    
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
            analytsicsManager.logBeginCheckOut();
          }, child: Text("logBeginCheckOut")),
          ElevatedButton(onPressed: (){
            analytsicsManager.logEvent();
          }, child: Text("LogEvent")),
          ElevatedButton(onPressed: (){
            analytsicsManager.reserAnalyticsData();
          }, child: Text("Reset analytics data")),
          
          
        ],
      ),
      ),
    ),
    );
  }
}