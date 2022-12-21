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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (() {
                  tasksReference.get().then((value) {
                    //QuerySnapshot collection = value;
                    //List<QueryDocumentSnapshot> docs = collection.docs;
                    //QueryDocumentSnapshot doc = docs[1];
                    //print(doc.id);
                    //print(doc.data());

                    QuerySnapshot collection = value;
                    collection.docs.forEach((QueryDocumentSnapshot element) {
                      Map<String, dynamic> myMap =
                          element.data() as Map<String, dynamic>;
                      print(myMap["title"]);
                    });
                  });
                }),
                child: Text("Obtener la data"),
              ),
              ElevatedButton(
                onPressed: () {
                  tasksReference.add(
                    {
                      "title": "Ir de compras al super 2",
                      "descripcion":
                          "Debemos de comprar comdia para todoo el mes",
                    },
                  ).then((DocumentReference value) {
                    print(value.id);
                  }).catchError((error) {
                    print("Ocurrio un error en el registro");
                  }).whenComplete(() {
                    print("El registro ha terminado");
                  });
                },
                child: Text("Agregar Documento"),
              ),
              ElevatedButton(
                onPressed: () {
                  tasksReference.doc("CWJi2ClP3Tm3wnOSvkEa").update(
                    {
                      "title": "Ir de paseo",
                      "descripcion": "Tenems que salir muy temprano",
                    },
                  ).catchError(
                    (error) {
                      print(error);
                    },
                  ).whenComplete(
                    () {
                      print("Actualizacion terminada");
                    },
                  );
                },
                child: Text("Actualizar documento"),
              ),
              ElevatedButton(
                onPressed: () {
                  tasksReference
                      .doc("DAzrwsO00QPMHhRXIR8x")
                      .delete()
                      .catchError(
                    (error) {
                      print(error);
                    },
                  ).whenComplete(
                    () {
                      print("La eliminacion esta completa");
                    },
                  );
                },
                child: Text("Eliminar documento"),
              ),
              ElevatedButton(
                onPressed: () {
                  tasksReference.doc("A00001").set(
                    {
                      "title": "Ir al conciertoo",
                      "descripcion":
                          "Este fin de semana debemos ir al concierto",
                    },
                  ).catchError(
                    (error) {
                      print("Creacioon completada");
                    },
                  );
                },
                child: Text(
                  "Agregar documento personalizado",
                ),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: counter(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int data = snapshot.data;
                return Center(
                  child: Text(
                    data.toString(),
                    style: TextStyle(fontSize: 50),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}
