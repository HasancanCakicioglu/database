import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CloudStorage {
  final storageRef = FirebaseStorage.instance.ref();

  void uploadAsFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.absolute}/bigKnife.jpg';
    File file = File(filePath);

    try {
      
      await storageRef.child("images").child("mountainsFile.jpg").putFile(file);
      
    } on FirebaseException catch (e) {
      debugPrint("1 uploadToLocalFile $e");
    }catch(e){
      debugPrint("2 uploadToLocalFile $e");
    }
    
  }

  Future<void> uploadAsString() async {
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    try {
      await storageRef.child("images").child("mountainsString.jpg").putString(dataUrl);
      
    } on FirebaseException catch (e) {
      debugPrint("1 uploadToLocalFile $e");
    }catch(e){
      debugPrint("2 uploadToLocalFile $e");
    }
    
  }

  Future<void> uploadAsUint8List() async {
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    try {
      await storageRef.child("images").child("mountainsUint8list.jpg").putData(Uint8List(32));
      
    } on FirebaseException catch (e) {
      debugPrint("1 uploadToLocalFile $e");
    }catch(e){
      debugPrint("2 uploadToLocalFile $e");
    }
    
  }
  
  Future<void> getDonwloadURL() async {
    

    try {
      var gelen = await storageRef.child("images").child("mountainsString.jpg").getDownloadURL();
      print("getDownloadUrl = $gelen");
      
    } on FirebaseException catch (e) {
      debugPrint("1 uploadToLocalFile $e");
    }catch(e){
      debugPrint("2 uploadToLocalFile $e");
    }
    
  }

var mountainsRef =  FirebaseStorage.instance.ref().child("monitor/largeFile");
late Task task;

  Future<void> monitorUploads() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.absolute}/MonitorFile.png';
    File file = File(filePath);
    
    task = mountainsRef.putFile(file);

    try {
      
      mountainsRef.putFile(file).snapshotEvents.listen((taskSnapshot) {
  switch (taskSnapshot.state) {
    case TaskState.running:
      // ...
      break;
    case TaskState.paused:
      // ...
      break;
    case TaskState.success:
      // ...
      break;
    case TaskState.canceled:
      // ...
      break;
    case TaskState.error:
      // ...
      break;
  }
});
      
    } on FirebaseException catch (e) {
      debugPrint("1 uploadToLocalFile $e");
    }catch(e){
      debugPrint("2 uploadToLocalFile $e");
    }
    
  }

  Future<void> pauseUpload()async{
    try {
      bool paused = await task.pause();
      debugPrint(paused.toString());
    } catch (e) {
      debugPrint("pauseUpload $e");
    }
  }

   Future<void> resumeUpload()async{
    try {
      bool resume = await task.resume();
      debugPrint(resume.toString());
    } catch (e) {
      debugPrint("resumeUpload $e");
    }
  }

   Future<void> cancelUpload()async{
    try {
      bool canceled = await task.cancel();
      debugPrint(canceled.toString());
    } catch (e) {
      debugPrint("cancelUpload $e");
    }
  }

  Future<void> delete()async{
    try {
      await storageRef.child("images").child("delete").delete();
      
    } catch (e) {
      debugPrint("cancelUpload $e");
    }
  }

  

  
}
