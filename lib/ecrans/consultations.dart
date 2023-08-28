import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'consultations_consultations.dart';
import 'consultations_deroulement.dart';
import 'consultations_teleconsultations.dart';
import 'consultations_relations_mutuelle.dart';
//import '../drawer.dart';

class Ecran1 extends StatelessWidget {
  const Ecran1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double textContainerHeight = containerHeight * 1.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: const MyDrawerWidget(),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
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
              ),
            ),
            child: const Text(
              'Consultations',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          Container(
        
            height: textContainerHeight,
            width: containerWidth,
            color: Colors.red, // Couleur du container rouge
          ),
          Row(
         
            children: [
              GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran9()));
              },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: containerWidth / 2,
                  height: containerHeight,
                  decoration: const BoxDecoration(
                  
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-1.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFDE8C07),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Consultations',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                ),
              ),


               GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran10()));
              },
                 child: Container(
                    alignment: Alignment.bottomCenter,
                  width: containerWidth / 2,
                  height: containerHeight,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-2.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFDE8C07),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Déroulement',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                             ),
               ),
            ],
          ),
          Row(
            children: [
               GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran11()));
              },
                 child: Container(
                 alignment: Alignment.bottomCenter,
                  width: containerWidth / 2,
                  height: containerHeight,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-3.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFDE8C07),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Téléconsultations',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                             ),
               ),
              GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran12()));
              },
                child: Container(
                   alignment: Alignment.bottomCenter,
                  width: containerWidth / 2,
                  height: containerHeight,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-4.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFDE8C07),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Relations Mutuelle',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
    );
  }
}
