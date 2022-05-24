import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MiApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  Color _numberTextColor = Colors.deepOrange;
  Color _changingTextColor = Colors.black;
  IconData _iconThemeMode = Icons.dark_mode;


  void _incrementCounterAndChangeTextColor() {
    setState(() {
      _incrementCounter();  // Should I really use a function in his case? 
      _changeTextColor();
    });
  }

  void _incrementCounter() { _counter++;} 

  void _decrementCounterAndChangeTextColor() {
    setState(() {
      _decrementCounter();
      _changeTextColor();
    });
  }

  void _decrementCounter() { _counter--;}

  void _changeTextColor() {
    _numberTextColor = _createTextColorRandomly();
    _changingTextColor = _createTextColorRandomly();  // ojo, low cohesion
  }

  Color _createTextColorRandomly() {
    final int red = _generateRandomNumber(255);
    final int green = _generateRandomNumber(255);
    final int blue = _generateRandomNumber(255);
    return Color.fromARGB(255, red, green, blue);
  }

  int _generateRandomNumber(int num) {
    final random = Random();
    return random.nextInt(num);
  }

  void _changeThemeMode() {
    setState(() {
      if (_backgroundColor == Colors.white){  // hide this implementation, Madge!
        _changeToDarkMode();
        return;
      }
      _changeToLightMode();
    });
  }

  void _changeToDarkMode() {
    _backgroundColor = Colors.grey[900] as Color;
    _textColor = Colors.white70;
    _iconThemeMode = Icons.light_mode;
  }

  void _changeToLightMode() {
    _backgroundColor = Colors.white;
    _textColor = Colors.black;
    _iconThemeMode = Icons.dark_mode;
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _changeThemeMode,
                  heroTag: null,
                  child: Icon(_iconThemeMode),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You\'ve touched me :',
                  style: Theme.of(context).textTheme.headline5
                  ?.copyWith(color: _textColor),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline3
                  ?.copyWith(color: _numberTextColor),
                ),
                Text(
                  "many times ( ͡° ͜ʖ ͡°)",
                  style: Theme.of(context).textTheme.headline5
                  ?.copyWith(color: _textColor),
                ),
                Text(
                  "I'm changing \\(￣▽￣)/",
                  style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(color: _changingTextColor),
                ),
              ],
            ),
            const Text(""),  //weit, this is illegal xd
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounterAndChangeTextColor,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementCounterAndChangeTextColor,
            heroTag: null,
            child: const Icon(Icons.remove),
          ),
        ]
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
