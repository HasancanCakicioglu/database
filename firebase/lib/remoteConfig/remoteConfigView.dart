

import 'package:firebase/remoteConfig/remoteConfigManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class remoteConfigView extends StatefulWidget {
  remoteConfigView({Key? key}) : super(key: key);

  @override
  State<remoteConfigView> createState() => _remoteConfigViewState();
}

class _remoteConfigViewState extends State<remoteConfigView> {
  late RemoteConfigManager remoteConfigManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remoteConfigManager = RemoteConfigManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<FirebaseRemoteConfig>(
                
                future: remoteConfigManager.fetchAndActive(),
                builder: (context,AsyncSnapshot<FirebaseRemoteConfig> snaphsot){
                return snaphsot.hasData ? Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.network(snaphsot.data!.getString("image"),fit: BoxFit.cover,),
                    ),
                    Text(snaphsot.data!.getInt("example_param_1").toString()),
                    Text(snaphsot.data!.getBool("example_param_2").toString()),
                    Text(snaphsot.data!.lastFetchStatus.toString()),
                    Text(snaphsot.data!.lastFetchTime.toString()),
                  ],
                ) : Container();
              }),
              
              ElevatedButton(
                  onPressed: () {
                    remoteConfigManager.fetchAndActive();
                  },
                  child: Text("fetchAndActive")),
                  

              
            ],
          ),
        ),
      ),
    );
  }
}
