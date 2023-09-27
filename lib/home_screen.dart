import 'package:flutter/material.dart';
import 'ecrans/consultations.dart';
import 'ecrans/ateliers_prevention.dart';
import 'ecrans/infos_nutrition.dart';
import 'ecrans/recettes.dart';
import 'ecrans/temoignages.dart';
import 'ecrans/contacts.dart';
import 'drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calcul du nombre de conteneurs
    //int numberOfContainers = 6;
    // Calcul de la hauteur des conteneurs en fonction de l'espace disponible
    //double containerHeight =
       // MediaQuery.of(context).size.height / numberOfContainers;
    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF609a7d),
         centerTitle: true,
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 254, 254, 254)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Consultations(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFDE8C07),
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
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFDE8C07),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),

                    //padding: const EdgeInsets.all(16.0),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Consultations',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        // backgroundColor: Color(0xFFDE8C07),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AtelierPrevention(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF548235),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF548235),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF548235),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Ateliers prévention',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        //backgroundColor: Color(0xFF548235),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InfosNutrition(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/infos_nutrition.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF2196F3),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Infos nutrition',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 252, 252, 252),
                        // backgroundColor: Color(0xFF2196F3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Recettes(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF9C27B0),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF9C27B0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Recettes',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        //  backgroundColor: Color(0xFF9C27B0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Temoignages(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF795548),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/temoignages.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFF795548),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF795548),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Temoignages',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        //  backgroundColor: Color(0xFF795548),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Contacts(),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE91E63),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/contact.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFFE91E63),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE91E63),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(300.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(
                              255, 5, 5, 5), // Couleur de l'ombre
                          offset: Offset(2,
                              -2), // Décalage vertical négatif pour l'ombre en haut
                          blurRadius: 4, // Flou de l'ombre
                          spreadRadius: 0, // Écart de l'ombre
                        ),
                      ],
                    ),
                   width: containerWidth * 0.4,
                    child: const Text(
                      'Me Contacter',
                      style: TextStyle(
                      fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        //backgroundColor: Color(0xFFE91E63),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
