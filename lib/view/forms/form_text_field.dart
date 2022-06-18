import 'package:flutter/material.dart';


class FormTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final field;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  // ignore: prefer_typing_uninitialized_variables
  final setState;
  const FormTextField({Key? key, this.field, this.data, this.setState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}",
        border: const OutlineInputBorder(),
      ),
      initialValue: data[field],
      validator: (value) {
        if (value!.length < 2) {
          return "Ingrese al menos 2 caracteres";
        } else {
          return null;
        }
      },
      onChanged: (value) => setState(() => data[field] = value),
    );
  }
}