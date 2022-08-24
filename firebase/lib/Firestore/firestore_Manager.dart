import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Firestore/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final moviesRef = FirebaseFirestore.instance.collection('movies').withConverter<Movie>(
      fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );

class FireStoreManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String name, int age) async {
    await firestore
        .collection("users")
        .add({"name": name, "age": age})
        .then((value) => print("user add"))
        .catchError((e) => print("add error = $e"));
  }
  Future<void> setWithDoc(String name, int age,String doc) async {
    await firestore
        .collection("users").doc(doc).set({"name": name, "age": age},SetOptions(mergeFields:["age"]))
        .then((value) => print("user add"))
        .catchError((e) => print("add error = $e"));
  }   //mergeFields sadece o değeri değiştiriyor diğerleri aynı kalıyor
  Future<DocumentSnapshot<Map<String,dynamic>>> getWithDoc(String doc) async {
    
      var gelen = await firestore
        .collection("users").doc(doc)
        .get();
        debugPrint("getWithDoc = ${gelen.data()}");

        return gelen;
     
       
  }

  Future<void> get() async {
    try {
        var gelen = await firestore
        .collection("users")
        .get();
      
        debugPrint("get = ${gelen.docs}");
        debugPrint("get = ${gelen.docs[0].data()}");
    } catch (e) {
      
    }
        
  }

  Stream<QuerySnapshot> snapshotStream = FirebaseFirestore.instance.collection('users').snapshots();


  Future<void> getWithTerms()async{
    await firestore.collection("users").where("age",isGreaterThan: 50).orderBy("age").limitToLast(3).get().then((value) =>print("getWithTerms value = ${value.docs[0].data()}"));
  }



  Future<void> getWithModel(String doc) async {
  
  // Get a movie with the id 42
  Movie movie42 = await moviesRef.doc(doc).get().then((snapshot) => snapshot.data()!);
  print("getWithModel = "+movie42.title.toString());
}

Future<void> addWithModel(String title,String genre) async {

  // Add a movie
  await moviesRef.add(
    Movie(
      title: title,
      genre: genre
    ),
  ).then((value) => print("eKLENDİ value = ${value}"));
}



  Future<void> update(String updated) async{

   await firestore.collection("users")
    .doc('yeniDoc')
    .update({'name': updated})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}


Future<void> addImageUint8List() async{
  rootBundle
    .load('assets/bigKnife.jpg')
    .then((bytes) => bytes.buffer.asUint8List())
    .then((avatar) {
      firestore.collection("users")
        .doc('ABC123')
        .set({'info.avatar': Blob(avatar)});
      })
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

Future<void> delete() async{
  await firestore.collection("users")
    .doc('ABC123')
    .delete()
    .then((value) => print("User Deleted "))
    .catchError((error) => print("Failed to delete user: $error"));
}


Future<void> deleteField() async{
  await firestore.collection("users")
    .doc('k4XUMRLdyef4QaqpMeYs')
    .update({'age': FieldValue.delete()})
    .then((value) => print("User's Property Deleted"))
    .catchError((error) => print("Failed to delete user's property: $error"));
}

Future<void> transactionRun()async{

  DocumentReference documentReference1 = firestore.collection("transaction").doc("trans");
  DocumentReference documentReference2 = firestore.collection("transaction").doc("trans2");

  try {
    
    firestore.runTransaction((transaction) async{
      DocumentSnapshot snapshot1 =  await transaction.get(documentReference1);
      DocumentSnapshot snapshot2 =  await transaction.get(documentReference2);

      if(!snapshot1.exists && !snapshot2.exists){
        throw Exception("transaction excepiton");
      }
  
      int value1 = (snapshot1.data()! as Map)["money"];
      int value2 = (snapshot2.data()! as Map)["money"];

      if(value1 >100){
        transaction.update(documentReference1, {"money":value1-100});
        transaction.update(documentReference2, {"money":value2+100});
      }


    });

  } catch (e) {
    debugPrint("transaction $e");
  }

}

Future<void> batchDelete() async{
  WriteBatch batch = firestore.batch();

  await firestore.collection("batchDeneme").get().then((querySnapshot) {
    querySnapshot.docs.forEach((document) {
      batch.delete(document.reference);
    });

    return batch.commit();
  }).then((value) => debugPrint("BatchDeleted"));
}



  
}
