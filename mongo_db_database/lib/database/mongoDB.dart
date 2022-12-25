

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mongo_db_database/constants/mongoConstants.dart';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_database/enum/collections.dart';



class MongoDatabase {
  
  
  Db? db;
  static MongoDatabase? _instance;

  static MongoDatabase get instance{
    
    return _instance ??=MongoDatabase.init();
  }
  MongoDatabase.init();


  dbInitialize()async{
    if(db == null){
      db = await Db.create(MONGO_URL);
    await db!.open();
    inspect(db);
    }
    
  }




  Future<WriteResult> insertOne(String name,int age,String email)async{

    WriteResult writeResult =await db!.collection(Collections.users.name).insertOne({
      "username":name,
      "age":age,
      "email":email
    });
    debugPrint(writeResult.toString());

    return writeResult;

  }

  Future<BulkWriteResult> insertMany(List<Map<String,dynamic>> insertManyList)async{

    BulkWriteResult bulkWriteResult = await  db!.collection(Collections.users.name).insertMany(insertManyList);
    debugPrint(bulkWriteResult.toString());
    return bulkWriteResult;

  }

  Future<WriteResult?> updateOne(String area,int age)async{

    WriteResult? writeResult = await db?.collection(Collections.users.name).updateOne(where.eq("age",45),modify.set(area, age));
    debugPrint(writeResult.toString());
    return writeResult;

  }

  Future<WriteResult> deleteOne()async{

    WriteResult writeResult = await db!.collection(Collections.users.name).deleteOne(where.gt("age", 100));
    debugPrint(writeResult.toString());
    return writeResult;

  }

  Future findOne()async{

    Map<String,dynamic>? map = await db!.collection(Collections.users.name).findOne(where.eq("age", 45).gt("age", 44));
    debugPrint(map!.entries.toString());
    return map;

  }

  

}