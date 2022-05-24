import 'package:flutter/material.dart';
import 'package:flutter_application_1/changeable_text_color.dart';
import 'package:flutter_application_1/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeableTextColor(), //ChangeableTextColor() or HomeView()
    );
  }
}
