import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Firestore/firestore_Manager.dart';
import 'package:firebase/firebaseMessaging/messaging_View.dart';
import 'package:flutter/material.dart';

class firebaseMessaging extends StatefulWidget {
  firebaseMessaging({Key? key}) : super(key: key);

  @override
  State<firebaseMessaging> createState() => _firebaseMessagingState();
}

class _firebaseMessagingState extends State<firebaseMessaging> {
  late MessagingManager messageeManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageeManager = MessagingManager();
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
                messageeManager.askPermission();
              }, child: Text("ask permmission")),
              ElevatedButton(onPressed: (){
                messageeManager.onMessageListen();
              }, child: Text("on Message Listen")),
              ElevatedButton(onPressed: (){
                messageeManager.getNotificationSettings();
              }, child: Text("getNotificationSettings")),
              ElevatedButton(onPressed: (){
                messageeManager.createChannel();
              }, child: Text("createChannel")),
              ElevatedButton(onPressed: (){
                messageeManager.subscribe("weather");
              }, child: Text("subscribe")),
              ElevatedButton(onPressed: (){
                messageeManager.unSubscribe("weather");
              }, child: Text("unSubscrbie")),
            ],
          ),
        ),
      ),
    );
  }
}
