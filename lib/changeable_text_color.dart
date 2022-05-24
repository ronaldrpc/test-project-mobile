import 'dart:math';
import 'package:flutter/material.dart';

class ChangeableTextColor extends StatelessWidget {
  const ChangeableTextColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CounterTextColor();
  }
}

class CounterTextColor extends StatefulWidget {
  const CounterTextColor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CounterTextColor();
  }
}

class _CounterTextColor extends State<CounterTextColor> {
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

  void _incrementCounter() {
    _counter++;
  }

  void _decrementCounterAndChangeTextColor() {
    setState(() {
      _decrementCounter();
      _changeTextColor();
    });
  }

  void _decrementCounter() {
    _counter--;
  }

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
      if (_backgroundColor == Colors.white) {  // hide this implementation, Madge!
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Changeable text color"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                right: 20.0
              ),
              child: FloatingActionButton(
                onPressed: _changeThemeMode,
                heroTag: null,
                child: Icon(_iconThemeMode),
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You\'ve touched me',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: _textColor),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: _numberTextColor),
                ),
                Text(
                  "many times ( ͡° ͜ʖ ͡°)",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: _textColor),
                ),
                Text(
                  "I'm changing 〜(￣▽￣〜)",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: _changingTextColor),
                ),
              ],
            ),
            const Text(""), //weit, this is illegal xd
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end, 
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 10.0
            ),
            child: FloatingActionButton(
              onPressed: _incrementCounterAndChangeTextColor,
              heroTag: null,
              child: const Icon(Icons.add),
            )
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 5.0
            ),
            child: FloatingActionButton(
              onPressed: _decrementCounterAndChangeTextColor,
              heroTag: null,
              child: const Icon(Icons.remove),
            )
          ),
        ]
      ),
    );
  }
}
