
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthManager{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> adjustTestOrRealAuth()async{
    String localHost = Platform.isAndroid ? "10.0.2." : "localhost";

    await firebaseAuth.useAuthEmulator(localHost,9099);

  }


  

}



