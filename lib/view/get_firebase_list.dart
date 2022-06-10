import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/firebase_connection.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'dart:convert';

import 'package:flutter_application_1/entities/response_firebase.dart';

class CallFirebase extends StatefulWidget {
  const CallFirebase({Key? key}) : super(key: key);

  @override
  State<CallFirebase> createState() => _CallFirebaseState();
}

class _CallFirebaseState extends State<CallFirebase> {
  List<Record> records = [];
  FirebaseConnection con = FirebaseConnection();
  late ResponseFirebase response;

  Future<void> getRecordsFromFirebase() async {
    final dbRecords = await con.getRecords();
    //print(dbRecords);
    final res = ResponseFirebase.fromJson(dbRecords);
    setState(() {
      records = res.records!;
    });

    //Probando obtener un registro especifico con la key = 1213141
    // final dbSpecificRecord = await con.getRecordByPath('Registros/1213141');
    // print(dbSpecificRecord);
  }

  
  @override
  Widget build(BuildContext context) {
    
    getRecordsFromFirebase();
    //callDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista registros'),
      ),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text("${records[index].nombre!} ${records[index].apellido!}"),
            onTap: () {
              openAlertDialog(context, records[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow_rounded)
      ),
    );
  }

  void openAlertDialog(BuildContext context, Record persona) {
    AlertDialog alert = AlertDialog(
      title: Text(persona.nombre! + " " + persona.apellido!),
      content: Text(persona.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        )
      ]
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void callDatabase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref("/Registros");

    ref.onValue.listen((event) {
      print("inside stream");
      final data = event.snapshot.value;
      final dataEncoded = json.encode(data);
      // var temp = {"123456789": ":v"};
      // print(temp);
      // print(data);
      final Map<String, dynamic> mappedData = json.decode(dataEncoded);
      // final mappedData = Map<String, dynamic>.from(data as Map);
      
      List<Record> people = [];
      mappedData.forEach((key, value) {
        // print('$key - $value');
        Record person = Record.fromJson(value);
        people.add(person);
        //print(person.carro!.marca);
      });
    });
    print("outside stream");
  }

}




  // Future<void> callDatabase() async {
  //   FirebaseDatabase database = FirebaseDatabase.instance;
  //   DatabaseReference ref = database.ref("/Registros");
  //   ref.onValue.listen((event) {
  //     final data = event.snapshot.value;
  //     data.toString();
  //   }); 

  //   int id = 1213141;
  //   final ref = FirebaseDatabase.instance.ref();
  //   final snapshot = await ref.child('Registros/$id').get();

  //   if (snapshot.exists){
  //     print(snapshot.value);
  //   }
  //   else {
  //     print("No data");
  //   }
  // }