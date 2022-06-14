import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/view/changeable_text_color.dart';
import 'package:flutter_application_1/view/count_screen.dart';
import 'package:flutter_application_1/view/records/record_home.dart';
import 'package:flutter_application_1/view/records/record_list_view.dart';
import 'package:flutter_application_1/view/home_view.dart';
import 'package:flutter_application_1/view/listview_1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
  //callDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      home: const RecordHome(), //ListView1() or ChangeableTextColor() or HomeView() or Counter()
    );
  }
}
