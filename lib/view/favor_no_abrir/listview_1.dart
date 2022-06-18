import 'package:flutter/material.dart';

class ListView1 extends StatelessWidget {
  const ListView1({Key? key}) : super(key: key);

  final games = const ["Genshin Impact", "Borderlands", "Final Fantasy XV", "Crossfire", "Honkai Impact"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videojuegos")
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.cloud_circle_outlined),
            title: Text(games[index]),
            onTap: () {
              openAlertDialog(context, games[index]);
            },
          );
        },
      ),
    );
  }

  void openAlertDialog(BuildContext context, String info) {
    AlertDialog alert = AlertDialog(
      title: Text(info),
      content: Text("El juego se llama $info"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        )
      ]
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
