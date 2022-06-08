import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/person.dart';
import 'dart:convert';

class CallFirebase extends StatefulWidget {
  const CallFirebase({Key? key}) : super(key: key);

  @override
  State<CallFirebase> createState() => _CallFirebaseState();
}

class _CallFirebaseState extends State<CallFirebase> {
  List<Person> records = [];
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    
    
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
        onPressed: () => getRecordList(),
        child: const Icon(Icons.play_arrow_rounded)
      ),
    );
  }

  void openAlertDialog(BuildContext context, Person persona) {
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

  //-------------------------------------------------------

  void getRecordList() {
    print(":v");
    final ref = referenceDatabase.ref('/Registros');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      final mappedData = convertCollectionToJSON(data);
      createModelObjects(mappedData);
    });
  }

  Map<String, dynamic> convertCollectionToJSON(data) {
    final dataEncoded = json.encode(data);
    final Map<String, dynamic> mappedData = json.decode(dataEncoded);
    return mappedData;
  }

  void createModelObjects(mappedData) {
    List<Person> tempRecords = [];
    mappedData.forEach((key, value) {
      Person person = Person.fromJson(value);
      tempRecords.add(person);
    });
    setState(() {
      records = tempRecords;
    });
  }

  
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void callDatabase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref("/Registros");

    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      final dataEncoded = json.encode(data);
      // var temp = {"123456789": ":v"};
      // print(temp);
      // print(data);
      final Map<String, dynamic> mappedData = json.decode(dataEncoded);
      // final mappedData = Map<String, dynamic>.from(data as Map);
      
      List<Person> people = [];
      mappedData.forEach((key, value) {
        // print('$key - $value');
        Person person = Person.fromJson(value);
        people.add(person);
        print(person.carro!.marca);
      });
    });
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