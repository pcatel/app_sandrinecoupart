import 'package:flutter/material.dart';
import '../bottom_navigation_atelier_prevention.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'alimentation_durable.dart';
import 'cuisine_enfant_parent.dart';
import 'cuisine_quotidien.dart';
import 'alimentation_travail.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drawer.dart';

class AtelierPrevention extends StatefulWidget {
  const AtelierPrevention({super.key});

  @override
  AtelierPreventionState createState() => AtelierPreventionState();
}

class AtelierPreventionState extends State<AtelierPrevention> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_ateliers_prevention.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.10;
    //double fittedBoxHeight = MediaQuery.of(context).size.height * 0.60;
    double containerWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: const Color(0xFF84A66F),
      drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF548235),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center, // Alignez en haut de l'écran
            height: containerHeight,
            width: containerWidth,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 117, 17, 17),
              image: DecorationImage(
                image: NetworkImage(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/consultation.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFF548235),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Ateliers prévention',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 7, 7),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.center,
            width: containerWidth,
            child: ClipPath(
              clipper: WaveClipper(), // Utilisation du clipper personnalisé
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/ateliers_prevention.jpg',
                width: containerWidth,
                height: 300, // Hauteur de l'image
                fit: BoxFit.cover,
                
              ),
            ),
          ),
          Expanded(
            // Utilisez Expanded pour prendre le reste de l'espace disponible
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
                  return SingleChildScrollView(
                    child: Container(
                      //color: const Color(0xFF84A66F),
                      child: Column(
                        children: dataList.map((item) {
                          List<String> separatedText = item.split(':');
                          String title = separatedText[0];
                          String description =
                              separatedText.length > 1 ? separatedText[1] : '';
                          return ExpansionTile(
                            backgroundColor: const Color(0xFFD5EEC5),
                            title: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  description,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter, // Alignez en bas de l'écran
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlimentationDurable(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: containerWidth / 2,
                        height: containerHeight,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/alimentation_durable.jpg',
                            ),
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //  Color(0xFF548235),
                            //  BlendMode.color,
                            // ),
                          ),
                        ),
                        child: Container(
                        alignment: Alignment.center,
                  height: 30,
                  width:double.infinity,
                  color: const Color.fromARGB(255, 214, 246, 193),
                          child: const Text(
                            'Alimentation durable',
                           style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 7, 7),
                               
                              ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CusineEnfantParent(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: containerWidth / 2,
                        height: containerHeight,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/cuisine_enfants_parents.jpg',
                            ),
                            fit: BoxFit.cover,
                           
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                  height: 30,
                  width:double.infinity,
                  color: const Color.fromARGB(255, 214, 246, 193),
                          child: const Text(
                            'Cuisine enfants et parents',
                           style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 7, 7),
                             
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CusineQuotidien(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: containerWidth / 2,
                          height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/cuisine_au_quotidien.jpg',
                              ),
                              fit: BoxFit.cover,
                             
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                  height: 30,
                  width:double.infinity,
                  color: const Color.fromARGB(255, 214, 246, 193),
                            child: const Text(
                              'Cuisine au quotidien',
                             style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 7, 7),
                               
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AlimentationTravail(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: containerWidth / 2,
                          height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                 'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/alimentation_au_travail.jpg',
                              ),
                              fit: BoxFit.cover,
                             // colorFilter: ColorFilter.mode(
                            //    Color(0xFF548235),
                            //    BlendMode.color,
                            //  ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                  height: 30,
                  width:double.infinity,
                  color: const Color.fromARGB(255, 214, 246, 193),
                            child: const Text(
                              'L\'alimentation au travail',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 7, 7),
                               
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF548235),
      ),
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
