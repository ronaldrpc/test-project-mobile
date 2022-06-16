import 'package:flutter/material.dart';


class FormCheckField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final field;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  // ignore: prefer_typing_uninitialized_variables
  final setState;
  const FormCheckField({Key? key, this.field, this.data, this.setState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isChecked = (data[field] == "si") ? true : false;
    return CheckboxListTile(
      title: Text("${field.toString()[0].toUpperCase()}${field.toString().substring(1).toLowerCase()}"),
      value: isChecked,
      onChanged: (value) => setState(() {
        data[field] = (value!) ? "si" : "no";
      })
    );
  }
}