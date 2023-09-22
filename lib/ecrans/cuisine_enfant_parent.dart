import 'package:flutter/material.dart';
import '../bottom_navigation_atelier_prevention.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
//import '../drawer.dart';

class CusineEnfantParent extends StatefulWidget {
  const CusineEnfantParent({super.key});

  @override
 CusineEnfantParentState createState() => CusineEnfantParentState();
}

class CusineEnfantParentState extends State<CusineEnfantParent> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_cuisine_enfant_parent.php'));

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
    //double textContainerHeight = containerHeight * 1.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF548235),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Color(0xFF548235),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Cuisine enfants et parents',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.center,
            width: containerWidth,
            child: ClipPath(
              clipper: WaveClipper(), // Utilisation du clipper personnalisé
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/cuisine_enfants_parents.jpg',
                width: containerWidth,
                height: 300, // Hauteur de l'image
                fit: BoxFit.cover,
              ),
            ),
          ),
          FittedBox(
          fit: BoxFit.scaleDown,
            child: SizedBox(
              //height: textContainerHeight,
              width: containerWidth*0.8,
              //color: Colors.red, // Couleur du container rouge
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
                List<String> dataList = snapshot.data ?? []; // Add this line to handle null data
                String queryResult = dataList.join('\n');
                return SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              queryResult,
               style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
            ),
                  ),
                );
              }
            },
          ),
          
            ),
          ),
          
          
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFF548235)),
    );
  }
}
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8); // Début du chemin
    path.quadraticBezierTo(
        size.width / 4, size.height * 0.9, size.width / 2, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 0.7, size.width, size.height * 0.8);
    path.lineTo(size.width, 0); // Fin du chemin
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


