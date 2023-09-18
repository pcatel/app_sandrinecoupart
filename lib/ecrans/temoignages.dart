import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import '../drawer.dart';

//import '../drawer.dart';
class Temoignages extends StatelessWidget {
  const Temoignages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF795548),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        height: containerHeight,
        width: containerWidth,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/temoignages.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color(0xFF795548),
                BlendMode.color,
              ),
            )),
        child: const Text(
          'Temoignages',
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF795548),
      ),
    );
  }
}
