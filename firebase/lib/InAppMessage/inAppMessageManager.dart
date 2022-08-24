import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class InAppMessageManager{


  Future<void> triggerEvent(String event)async{
    FirebaseInAppMessaging.instance.triggerEvent(event);
  }

  Future<void> setDisableInAppMessage()async{
    FirebaseInAppMessaging.instance.setMessagesSuppressed(true);//mesaj görülmesini engeller
  }

  Future<void> setEnableInAppMessage()async{
    FirebaseInAppMessaging.instance.setMessagesSuppressed(false);//mesaj görülmesinin engelini kaldırır
  }

}