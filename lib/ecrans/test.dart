import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Step {
  final int number;
  final String title;

  Step(this.number, this.title);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Vertical Steps Line')),
        body: StepLine(),
      ),
    );
  }
}

class StepLine extends StatelessWidget {
  final List<Step> steps = [
    Step(1, 'Étape 1'),
    Step(2, 'Étape 2'),
    Step(3, 'Étape 3'),
    Step(4, 'Étape 4'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    steps[index].number.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(steps[index].title),
            ],
          ),
        );
      },
    );
  }
}
