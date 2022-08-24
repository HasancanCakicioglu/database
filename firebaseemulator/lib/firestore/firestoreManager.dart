import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreManager {
  static const bool USE_EMULATOR = true;

  Future<void> adjustTestOrReal() async {
    if (USE_EMULATOR) {
      await _connectToFirebaseEmulator();
    }
  }

  Future _connectToFirebaseEmulator() async {
    final localHostString = Platform.isAndroid ? "10.0.2.2" : "localhost";

    

    FirebaseFirestore.instance.settings = Settings(
      host: "$localHostString:8080",
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }
}
