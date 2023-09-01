import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'alimentation_durable.dart';
import 'cuisine_enfant_parent.dart';
import 'cuisine_quotidien.dart';
import 'alimentation_travail.dart';
import 'package:google_fonts/google_fonts.dart';

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
    

    double containerHeight = MediaQuery.of(context).size.height *
        0.10;
    double fittedBoxHeight = MediaQuery.of(context).size.height *
        0.50;
    double sizedBoxHeight = MediaQuery.of(context).size.height *
        0.40;
    
    
    
    double containerWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF609a7d),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 1, 1),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: containerHeight,
            width: containerWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
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
          Container(
            height: fittedBoxHeight,
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
                  return SingleChildScrollView(
                    child: Container(
                      color: const Color.fromARGB(255, 132, 166, 111),
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
                                  style: GoogleFonts.nanumPenScript(
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
            height: containerHeight,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                height: sizedBoxHeight/2,
                  child: Row(
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
                          //height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-1.jpg',
                              ),
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
                              color: Color.fromARGB(255, 7, 7, 7),
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
                          // height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-2.jpg',
                              ),
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
                              color: Color.fromARGB(255, 7, 7, 7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                height: sizedBoxHeight/2,
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
                         // height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-3.jpg',
                              ),
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
                              color: Color.fromARGB(255, 7, 7, 7),
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
                      //   height: containerHeight,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-4.jpg',
                              ),
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
                              color: Color.fromARGB(255, 7, 7, 7),
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
