import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class FirebaseConnection {
  
  DatabaseReference instanceFirebase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    return database.ref('');
  }

  Future<Map<String, dynamic>> getRecords() async {
    final snapshot = await instanceFirebase().get();
    if (snapshot.exists){
      return formatFirebaseDataToJSON(snapshot.value);
    }
    return {};
  }

  Future<Object?> getRecordByPath(String path) async {
    final snapshot = await instanceFirebase().child(path).get();
    if (snapshot.exists){
      return formatFirebaseDataToJSON(snapshot.value);
    }
    return null;
  }

  Map<String, dynamic> formatFirebaseDataToJSON(data) {
    final dataEncoded = json.encode(data);
    return json.decode(dataEncoded);
  }
  
}