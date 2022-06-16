import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/firebase_connection.dart';
import 'package:flutter_application_1/entities/record.dart';
import 'package:flutter_application_1/view/records/record_form.dart';

class RecordListView extends StatefulWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  State<RecordListView> createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  final connection = FirebaseConnection();
  final searchController = TextEditingController();
  List<Record> records = [];
  List<Record> recordsToSearch = [];

  Future<void> getRecordsFromFirebase() async {
    if (records.isEmpty) {
      final recordList = await connection.getRecords();
      setState(() {
        records = recordList.records!;
        recordsToSearch = records;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    getRecordsFromFirebase();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listar registros', 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              controller: searchController,
              onChanged: searchRecord,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Nombres Apellidos",
                contentPadding: const EdgeInsets.all(15),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: recordsToSearch.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    "${recordsToSearch[index].nombre!} ${recordsToSearch[index].apellido!}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)
                  ),
                  onTap: () {
                    //openAlertDialog(context, recordsToSearch[index]);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (content) {
                          return RecordForm(action: "Editar", record: recordsToSearch[index]);
                        }
                      )
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void openAlertDialog(BuildContext context, Record persona) {
    AlertDialog alert = AlertDialog(
      title: Text("${persona.nombre!} ${persona.apellido!}"),
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

  void searchRecord(String input) {
    final filteredRecords = records.where((record) {
      final nombresApellidos = "${record.nombre!.toLowerCase()} ${record.apellido!.toLowerCase()}";
      return nombresApellidos.contains(input.toLowerCase());
    }).toList();

    setState(() {
      recordsToSearch = filteredRecords;
    });
  }
}

