// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class FormNumberField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final field;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  // ignore: prefer_typing_uninitialized_variables
  final setState;
  bool? editable = true;
  FormNumberField({Key? key, this.field, this.data, this.setState, this.editable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: !editable!,
      decoration: InputDecoration(
        filled: !editable!,
        labelText: "${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}",
        border: const OutlineInputBorder(),
      ),
      initialValue: (data[field] != null) ? data[field].toString() : "",
      validator: (value) {
        if (value!.length < 2) {
          return "Ingrese al menos 2 caracteres";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      onChanged: (value) => setState(() => data[field] = int.parse(value)),
    );
  }
}