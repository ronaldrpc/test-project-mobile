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
              ]),
        ),
        floatingActionButton: FloatingCustomW(
          increment: incrementCounter, 
          decrement: decrementCounter,
          reset: resetCounter
        ));
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      count--;
    });
  }

  void resetCounter() {
    setState(() {
      count = 0;
    });
  }

  void showMessage() {
    //print("Hi, again");
  }
}

class FloatingCustomW extends StatelessWidget {
  final Function increment;
  final Function decrement;
  final Function reset;
  const FloatingCustomW({
    Key? key, required this.increment, required this.decrement, required this.reset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(onPressed: () => increment(), child: const Icon(Icons.add)),
        FloatingActionButton(onPressed: () {decrement();}, child: const Icon(Icons.remove)),
        FloatingActionButton(onPressed: () => reset(), child: const Icon(Icons.replay)),
      ],
    );
  }
}
