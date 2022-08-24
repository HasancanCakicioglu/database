import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Crashlytics/crashylticsView.dart';
import 'package:firebase/Firestore/fireStore_view.dart';
import 'package:firebase/InAppMessage/inAppMessageView.dart';
import 'package:firebase/addMob/addMobView.dart';
import 'package:firebase/analytics/analyticsView.dart';
import 'package:firebase/analytics/anayliyticManager.dart';
import 'package:firebase/cloudStorage/cloudStorageView.dart';
import 'package:firebase/dynamicLink/dynamicLinkManager.dart';
import 'package:firebase/dynamicLink/dynamicLinkView.dart';
import 'package:firebase/firebaseAuth/firebaseAuthView.dart';
import 'package:firebase/firebaseMessaging/firebase_messagingManager.dart';
import 'package:firebase/performanceMonitoring/performanceView.dart';
import 'package:firebase/remoteConfig/remoteConfigView.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp();
    MobileAds.instance.initialize();

    await FirebaseAppCheck.instance.activate(
      webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    );

    
    

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

//   Isolate.current.addErrorListener(RawReceivePort((pair) async {
//   final List<dynamic> errorAndStacktrace = pair;
//   await FirebaseCrashlytics.instance.recordError(
//     errorAndStacktrace.first,
//     errorAndStacktrace.last,
//   );
// }).sendPort);
}

 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      navigatorObservers: [
      
        AnalytsicsManager().appAnalyticsObserver(),
      ],
      routes: {
        "/": (context) => Home(),
        "/deepLinkView":(context)=>deepLinkView(),
      },
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DynamicLinkManager dynamicLinkManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamicLinkManager = DynamicLinkManager();
    dynamicLinkManager.initDynamicLinks(context);
  
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  firebaseAuth().go(context);
                },
                child: Text("Auth")),
            ElevatedButton(
                onPressed: () {
                  fireStoreView().go(context);
                },
                child: Text("firestore")),
            ElevatedButton(
                onPressed: () {
                  firebaseMessaging().go(context);
                },
                child: Text("Cloud Messaging")),
            ElevatedButton(
                onPressed: () {
                  firebaseAnalytcisView().go(context);
                },
                child: Text("Analytics")),
            ElevatedButton(
                onPressed: () {
                  cloudStorageView().go(context);
                },
                child: Text("cloudStorage")),
            ElevatedButton(
                onPressed: () {
                  crashlyticsView().go(context);
                },
                child: Text("crashyltics")),
            ElevatedButton(
                onPressed: () {
                  performanceView().go(context);
                },
                child: Text("Performance")),
            ElevatedButton(
                onPressed: () {
                  remoteConfigView().go(context);
                },
                child: Text("remote Config")),
            ElevatedButton(
                onPressed: () {
                  inAppMessageView().go(context);
                },
                child: Text("inAppMessage")),
            ElevatedButton(
                onPressed: () {
                  addMobView().go(context);
                },
                child: Text("addMob")),
          ],
        ),
      ),
    );
  }
}

extension navigasyon on Widget {
  go(BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => this));
  }
}
