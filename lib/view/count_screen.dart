import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 10;

  @override
  Widget build(BuildContext context) {
    const sizeText = TextStyle(fontSize: 25);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Let's count! ٩(◕‿◕｡)۶", style: sizeText),
            const Text("Count", style: sizeText),
            Text('$count', style: sizeText),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incrementCounter();
          showMessage();
        },
        child: const Icon(Icons.access_alarms)
      )
    );
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void showMessage() {
    print("Hi, again");
  }
}