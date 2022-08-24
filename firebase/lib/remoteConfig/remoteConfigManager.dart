import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class RemoteConfigManager {
  static RemoteConfigManager? _instance;

  factory RemoteConfigManager() => _instance ??= RemoteConfigManager._init();

  RemoteConfigManager._init(){
    print("RemoteConfigManager._init");
    setConfigSettings();
    setDefaultValues();
  }

  final remoteConfig = FirebaseRemoteConfig.instance;

  

  Future<void> setConfigSettings() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 0),
    ));
  }

  Future<void> setDefaultValues() async {
    await remoteConfig.setDefaults(const {
      "example_param_1": 3.14159,
      "example_param_2": true,
      "image":
          "https://avatars.mds.yandex.net/i?id=07cba44eccee85da47e45cf45394b262-5221692-images-thumbs&n=13",
    });
  }

  Future<FirebaseRemoteConfig> fetchAndActive() async {
    try{
      await remoteConfig.fetchAndActivate();
    }catch(e){
      debugPrint(" fetchAndActive ");
    }

    return remoteConfig;
  }
}


