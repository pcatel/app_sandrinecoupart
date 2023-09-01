import 'package:flutter/material.dart';




class MyList extends StatelessWidget {
  final List<String> items = [
    "Élément 1",
    "Élément 2",
    "Élément 3",
    "Élément 4",
    "Élément 5",
    "Élément 6",
  ];

  MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste Extensible"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MyExpansionTile(title: items[index]);
        },
      ),
    );
  }
}

class MyExpansionTile extends StatelessWidget {
  final String title;

  const MyExpansionTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Texte à l'intérieur de $title.",
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
