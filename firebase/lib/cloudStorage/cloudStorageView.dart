

import 'package:firebase/cloudStorage/cloudStorageManager.dart';
import 'package:flutter/material.dart';

class cloudStorageView extends StatefulWidget {
  cloudStorageView({Key? key}) : super(key: key);

  @override
  State<cloudStorageView> createState() => _cloudStorageViewState();
}

class _cloudStorageViewState extends State<cloudStorageView> {

  late CloudStorage cloudStorage;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    cloudStorage = CloudStorage();
    
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
            cloudStorage.uploadAsFile();
          }, child: Text("upload as File")),
          ElevatedButton(onPressed: (){
            cloudStorage.uploadAsUint8List();
          }, child: Text("upload as Uint8List")),
          ElevatedButton(onPressed: (){
            cloudStorage.uploadAsString();
          }, child: Text("upload as String")),
          ElevatedButton(onPressed: (){
            cloudStorage.getDonwloadURL();
          }, child: Text("getDownloadUrl")),
          ElevatedButton(onPressed: (){
            cloudStorage.monitorUploads();
          }, child: Text("monitorUploads")),
          ElevatedButton(onPressed: (){
            cloudStorage.pauseUpload();
          }, child: Text("pause Upload")),
          ElevatedButton(onPressed: (){
            cloudStorage.resumeUpload();
          }, child: Text("resume Upload")),
          ElevatedButton(onPressed: (){
            cloudStorage.cancelUpload();
          }, child: Text("cancel Upload")),
          ElevatedButton(onPressed: (){
            cloudStorage.delete();
          }, child: Text("delete")),

          
          
        ],
      ),
      ),
    ),
    );
  }
}