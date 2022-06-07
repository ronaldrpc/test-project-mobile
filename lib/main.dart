import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/changeable_text_color.dart';
import 'package:flutter_application_1/view/count_screen.dart';
import 'package:flutter_application_1/view/home_view.dart';
import 'package:flutter_application_1/view/listview_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListView1(), //ChangeableTextColor() or HomeView() or Counter()
    );
  }
}
