import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsManager {
  final FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.instance;

  Future<void> crash() async {
    firebaseCrashlytics.crash();
  }

  Future<void> crashDebugMode(bool bo) async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(bo);
    } else {}
  }
  Future<bool> isCrashlyticsCollectionEnabled() async {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
       print("isCrashlyticsCollectionEnabled is enabled");
       return true;
    }else{
      print("isCrashlyticsCollectionEnabled NOT NOT is enabled");
    }
    return false;
  }

  Future<void> toggleCrashlyticsCollectionEnabled() async {
    if(await isCrashlyticsCollectionEnabled()){
      crashDebugMode(false);
    }else{
  crashDebugMode(true);
    }
  }



  Future<void> throwError()async{
    try {
  throw Error();
} catch (e, s) {
  FirebaseCrashlytics.instance.recordError(e, s,reason: "example sample",fatal: false,printDetails: true,);
}
  }

  Future<void> log() async {
    firebaseCrashlytics.log("merhaba");
  }
}
