import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'consultations_consultations.dart';
//import 'consultations_deroulement.dart';
//import 'consultations_teleconsultations.dart';
//import 'consultations_relations_mutuelle.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../drawer.dart';

class AtelierPrevention extends StatefulWidget {
  const AtelierPrevention({super.key});

  @override
 AtelierPreventionState createState() => AtelierPreventionState();
}

class AtelierPreventionState extends State<AtelierPrevention> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation.php'));

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
              'Ateliers prévention',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          FittedBox(
          fit: BoxFit.scaleDown,
            child: SizedBox(
              height: textContainerHeight,
              width: containerWidth,
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
               style: GoogleFonts.nanumPenScript(fontSize: 20, fontWeight: FontWeight.bold),
            ),
                  ),
                );
              }
            },
          ),
          
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ConsultationsConsultations()));
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
                        Color(0xFF548235),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Alimentation durable',
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
                    MaterialPageRoute(builder: (context) => const AtelierPrevention()));
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
                        Color(0xFF548235),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cuisine enfants et parents',
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
                    MaterialPageRoute(builder: (context) => const AtelierPrevention()));
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
                        Color(0xFF548235),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cuisine au quotidien',
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
                    MaterialPageRoute(builder: (context) => const AtelierPrevention()));
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
                        Color(0xFF548235),
                        BlendMode.color,
                      ),
                    ),
                  ),
                  child: const Text(
                    'L\'alimentation au travail',
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
          const BottomNavigationBarScreen(backgroundColor: Color(0xFF548235)),
    );
  }
}

