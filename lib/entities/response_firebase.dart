
import 'package:flutter_application_1/entities/record.dart';

class ResponseFirebase {
  List<Record>? records;

  ResponseFirebase({this.records});

  ResponseFirebase.fromJson(Map<String, dynamic> json) {
    records = [];
    //print(json['Registros'].values.toList().runtimeType);
    json.forEach((key, value) {
      value['id'] = key;
      Record newRecord = Record.fromJson(value);
      records!.add(newRecord);
    });
  }

}