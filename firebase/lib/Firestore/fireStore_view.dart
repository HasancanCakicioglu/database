import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Firestore/firestore_Manager.dart';
import 'package:flutter/material.dart';

class fireStoreView extends StatefulWidget {
  fireStoreView({Key? key}) : super(key: key);

  @override
  State<fireStoreView> createState() => _fireStoreViewState();
}

class _fireStoreViewState extends State<fireStoreView> {
  late FireStoreManager firestoreManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreManager = FireStoreManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: firestoreManager.getWithDoc("yeniDoc"),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError || snapshot.connectionState==ConnectionState.waiting) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }
                    return Text("futureBuilder ${snapshot.data!.data()}");
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestoreManager.snapshotStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return Text("StreamBuilder lenght = ${snapshot.data?.docs.length}");
                  }),
              ElevatedButton(
                  onPressed: () {
                    firestoreManager.add("ali", 1);
                  },
                  child: Text("add")),
              ElevatedButton(
                  onPressed: () {
                    firestoreManager.setWithDoc("aliiiiiiyyyy", 222, "Lum8CI9HXHqRvGmk9UpM");
                  },
                  child: Text("setWithDoc")),
              ElevatedButton(
                  onPressed: () {
                    firestoreManager.get();
                  },
                  child: Text("get")),
              ElevatedButton(
                  onPressed: () {
                    firestoreManager.getWithDoc("yeniDoc");
                  },
                  child: Text("getWithDoc")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.getWithTerms();
                  },
                  child: Text("getWithTerms")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.getWithModel("eg6btoUNwcLWmKx4qLx2");
                  },
                  child: Text("getWithModel")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.addWithModel('Star Wars: A New Hope (Episode IV)',"Sci-fi");
                  },
                  child: Text("addWithModel")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.update("habibi");
                  },
                  child: Text("update")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.addImageUint8List();
                  },
                  child: Text("add image as BLOB")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.delete();
                  },
                  child: Text("delete Doc")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.deleteField();
                  },
                  child: Text("delete Field")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.transactionRun();
                  },
                  child: Text("run Transaction")),
                  ElevatedButton(
                  onPressed: () {
                    firestoreManager.batchDelete();
                  },
                  child: Text("batch Delete")),
            ],
          ),
        ),
      ),
    );
  }
}
