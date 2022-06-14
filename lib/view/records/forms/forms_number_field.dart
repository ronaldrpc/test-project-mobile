import 'package:flutter/material.dart';


class FormNumberField extends StatelessWidget {
  final field;
  final data;
  final setState;
  const FormNumberField({Key? key, this.field, this.data, this.setState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
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