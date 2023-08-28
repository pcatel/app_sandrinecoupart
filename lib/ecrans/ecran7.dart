import 'package:flutter/material.dart';

class Ecran7 extends StatelessWidget {
  const Ecran7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 7'),
      ),
      body: const Center(
        child: Text(
          'Page 7',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Ecran7(),
  ));
}
