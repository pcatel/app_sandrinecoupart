import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

//import '../drawer.dart';
class Ecran10 extends StatelessWidget {
  const Ecran10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF609a7d),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 1, 1)),
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
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/consultation.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color(0xFFDE8C07),
                BlendMode.color,
              ),
            )),
        child: const Text(
          'Déroulement',
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 7, 7, 7)),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor:   Color(0xFFDE8C07),
      ),
    );
  }
}
