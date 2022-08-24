import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkManager{
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks(BuildContext context) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      log("başladııııııııııııııııııııııııııııııııı");
      log("444444444444444444 "+dynamicLinkData.link.path.toString());
      Navigator.pushNamed(context, dynamicLinkData.link.path);
      
    },onDone: (){
       log("onDone");
    },onError: (e){
      log("error link $e");
    });
  }


}