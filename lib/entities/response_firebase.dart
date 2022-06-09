
import 'package:flutter_application_1/entities/record.dart';

class ResponseFirebase {
  List<Record>? records;

  ResponseFirebase({this.records});

  ResponseFirebase.fromJson(Map<String, dynamic> json) {
    records = [];
    // print(json['Registros'].runtimeType);
    json["Registros"].forEach((key, value) {
      records!.add(Record.fromJson(value));
    });
  }

}