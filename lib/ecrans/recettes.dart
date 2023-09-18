import 'package:flutter/material.dart';
import '../bottom_navigation_recettes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'menus.dart';
import 'recettes_allergies.dart';
import 'recettes_types_plats.dart';
import '../drawer.dart';

class Recettes extends StatefulWidget {
  const Recettes({super.key});

  @override
  RecettesState createState() => RecettesState();
}

class RecettesState extends State<Recettes> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_recettes.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double textContainerHeight = containerHeight * 1.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C27B0),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: containerHeight,
            width: containerWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
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
            child: const Text(
              'Recettes',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              height: textContainerHeight,
              width: containerWidth,
              child: FutureBuilder<List<String>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erreur de chargement des données');
                  } else if (!snapshot.hasData) {
                    return const Text('Aucune donnée disponible');
                  } else {
                    List<String> dataList = snapshot.data ?? [];
                    String queryResult = dataList.join('\n');
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          queryResult,
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            //height: containerHeight,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width:
                      300, // Définissez la largeur souhaitée pour les boutons
                  height:
                      50, // Définissez la hauteur souhaitée pour les boutons
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique de navigation pour "Voir les recettes" à implémenter ici
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecettesAllergies()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF9C27B0), // Couleur du bouton
                    ),
                    child: const Text('Recettes par types d\'allergies'),
                  ),
                ),
                const SizedBox(
                  height: 16, // Espace vertical entre les boutons
                ),
               
                SizedBox(
                  width:
                      300, // Définissez la largeur souhaitée pour les boutons
                  height:
                      50, // Définissez la hauteur souhaitée pour les boutons
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique de navigation pour "Voir les recettes" à implémenter ici
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecettesTypesPlats()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF9C27B0), // Couleur du bouton
                    ),
                    child: const Text('Recettes par types de plats'),
                  ),
                ),
                const SizedBox(
                  height: 50, // Espace vertical entre les boutons
                ),
                SizedBox(
                  width:
                      300, // Définissez la largeur souhaitée pour les boutons
                  height:
                      50, // Définissez la hauteur souhaitée pour les boutons
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique de navigation pour "Me connecter" à implémenter ici
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Menus()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF9C27B0), // Couleur du bouton
                    ),
                    child: const Text('Idées menus'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFF9C27B0)),
    );
  }
}
