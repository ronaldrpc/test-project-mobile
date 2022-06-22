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
    final recordList = await connection.getRecords();
    if (mounted && records.isEmpty) {
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
          'Lista de registros', 
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
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
                return CustomCard(records: recordsToSearch, index: index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetRecords,
        child: const Icon(Icons.refresh),
      ),
    );
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

  void resetRecords() {
    setState(() {
      records = [];
      recordsToSearch = [];
      showSnackBar();
    });
  }

  void showSnackBar() {
    const message = "Actualizado!";
    const snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomCard extends StatelessWidget {
  final List<Record> records;
  final int index;
  const CustomCard({Key? key, required this.records, required this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(193, 224, 227, 230),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Icon(Icons.person_outline),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${records[index].nombre!} ${records[index].apellido!}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    const Text("Nombre y apellido"),
                  ]
                )
              ]
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: TextButton(
                child: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (content) {
                        return RecordForm(action: "Editar", record: Record(), id: records[index].id!);
                        // return GetRecord(action: "Editar", recordId: records[index].id!);
                      }
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  
}

