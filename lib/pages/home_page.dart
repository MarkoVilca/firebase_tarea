import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_task/ui/general/colors.dart';
import 'package:firebase_task/ui/widgets/general_widget.dart';
import 'package:firebase_task/ui/widgets/textfield_search.dart';

class HomePage extends StatelessWidget {

  CollectionReference tasksReference = FirebaseFirestore.instance.collection('tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Firestore"),
      ),
      backgroundColor: kBrandSecondColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.85),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                  ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bienvenido, Ryoko", style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: kBrandPrimaryColor,
                        ),
                      ),

                    Text("Mis tareas", style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor,
                      ),
                    ),

                    divider10(),

      body: StreamBuilder(
        stream: tasksReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap){
          if(snap.hasData){
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            List<Map<String, dynamic>> docsMap = docs.map((e) => e.data() as Map<String, dynamic>).toList();
            print(docsMap);
            return ListView.builder(
              itemCount: docsMap.length,
              itemBuilder: (BuildContext contex, int index){
                return ListTile(
                  title: Text(docsMap[index]["title"]),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
                    TextFieldSearchWidget(),
                  ),
          ]
          ),
              ),
            ),
          ],
        ),
      ),

      //body: StreamBuilder(
        //stream: tasksReference.snapshots(),
        //builder: (BuildContext context, AsyncSnapshot snap){
          //if(snap.hasData){
            //QuerySnapshot collection = snap.data;
            //List<QueryDocumentSnapshot> docs = collection.docs;
            //List<Map<String, dynamic>> docsMap = docs.map((e) => e.data() as Map<String, dynamic>).toList();
            //print(docsMap);
            //return ListView.builder(
              //itemCount: docsMap.length,
              //itemBuilder: (BuildContext contex, int index){
                //return ListTile(
                  //title: Text(docsMap[index]["title"]),
                //);
              //},
            //);
          //}
          //return Center(child: CircularProgressIndicator(),);
        //},
      //),

    );
  }
}