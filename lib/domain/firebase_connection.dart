import 'package:firebase_database/firebase_database.dart';

class FirebaseConnection {
  
  DatabaseReference instanceFirebase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    return database.ref('');
  }

  Future<Object?> getRecords(DatabaseReference ref) async {
    final snapshot = await ref.get();
    if (snapshot.exists){
      return snapshot.value;
    }
    return null;
  }


  
}