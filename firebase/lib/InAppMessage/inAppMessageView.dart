
import 'package:firebase/InAppMessage/inAppMessageManager.dart';

import 'package:flutter/material.dart';

class inAppMessageView extends StatefulWidget {
  inAppMessageView({Key? key}) : super(key: key);

  @override
  State<inAppMessageView> createState() => _inAppMessageViewState();
}

class _inAppMessageViewState extends State<inAppMessageView> {
  late InAppMessageManager inAppMessageManager;

  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    inAppMessageManager = InAppMessageManager();
    
    
    
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
            inAppMessageManager.triggerEvent("2912157023350029192");
          }, child: Text("triggerEvent")),
          ElevatedButton(onPressed: (){
            inAppMessageManager.setDisableInAppMessage();
          }, child: Text("Disable")),
          ElevatedButton(onPressed: (){
            inAppMessageManager.setEnableInAppMessage();
          }, child: Text("Enable")),
          
          
          
        ],
      ),
      ),
    ),
    );
  }
}