import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/entities/response_firebase.dart';

class FirebaseConnection {
  
  DatabaseReference instanceFirebase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    return database.ref('/Registros');
  }

  Future<ResponseFirebase> getRecords() async {
    final snapshot = await instanceFirebase().get();
    if (snapshot.exists){
      final formatedJson = formatFirebaseDataToJSON(snapshot.value);
      return ResponseFirebase.fromJson(formatedJson);
    }
    return ResponseFirebase();
  }

  Future<ResponseFirebase> getRecordByPath(String path) async {
    final snapshot = await instanceFirebase().child(path).get();
    if (snapshot.exists){
      final valueJson = formatFirebaseDataToJSON(snapshot.value);
      final recordJson = {path: valueJson};
      return ResponseFirebase.fromJson(recordJson);
    }
    return ResponseFirebase();
  }

  Map<String, dynamic> formatFirebaseDataToJSON(data) {
    final dataEncoded = json.encode(data);
    return json.decode(dataEncoded);
  }

  Future<void> writeRecord(Map<String, dynamic> data, String id) async {
    final recordRef = instanceFirebase();
    await recordRef.child(id).update(data);
  }
  
}