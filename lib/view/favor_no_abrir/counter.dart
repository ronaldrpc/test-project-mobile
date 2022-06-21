/* import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const sizeText = TextStyle(fontSize: 25);
    int count = 10;

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
          count++;
          showMessage();
        },
        child: const Icon(Icons.access_alarms)
      )
    );
  }

  void showMessage() {
    print("Hi, again");
  }
} */