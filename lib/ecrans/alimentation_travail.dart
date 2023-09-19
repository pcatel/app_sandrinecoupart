import 'package:flutter/material.dart';
import '../bottom_navigation_atelier_prevention.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';

class AlimentationTravail extends StatefulWidget {
  const AlimentationTravail({Key? key}) : super(key: key);

  @override
  AlimentationTravailState createState() => AlimentationTravailState();
}

class AlimentationTravailState extends State<AlimentationTravail> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_alimentation_travail.php'));

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
    double textContainerHeight = containerHeight * 2.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
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
                'L\'alimentation au travail',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: containerWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/ateliers_prevention/alimentation_au_travail.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const AspectRatio(
                aspectRatio: 16 / 9,
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          queryResult,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF548235),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AlimentationTravail(),
    );
  }
}
