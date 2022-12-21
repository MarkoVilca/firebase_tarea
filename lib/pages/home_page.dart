import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');

  Stream<int> counter() async* {
    for (int i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<int> getNumber() async {
    return 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Firestore"),
        ),
        body: StreamBuilder(
            stream: counter(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData) {
                int data = snapshot.data;
                return Center(
                  child: Text(
                    data.toString(),
                    style: TextStyle(fontSize: 50),
                  ),
                );
                stream:
                tasksReference.snapshots();
                builder:
                (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    QuerySnapshot collection = snap.data;
                    List<QueryDocumentSnapshot> docs = collection.docs;
                    List<Map<String, dynamic>> docsMap = docs
                        .map((e) => e.data() as Map<String, dynamic>)
                        .toList();
                    print(docsMap);
                    return ListView.builder(
                      itemCount: docsMap.length,
                      itemBuilder: (BuildContext contex, int index) {
                        return ListTile(
                          title: Text(docsMap[index]["title"]),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
      );
     };
    } 
  })
  );
 }
}
