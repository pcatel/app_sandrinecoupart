import 'package:flutter/material.dart';
import '../bottom_navigation_consultations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Step {
  final int number;
  final String title;

  Step(this.number, this.title);
}

class ConsultationsTeleconsultation extends StatefulWidget {
  const ConsultationsTeleconsultation({super.key});

  @override
  ConsultationsTeleconsultationState createState() => ConsultationsTeleconsultationState();
}

class ConsultationsTeleconsultationState extends State<ConsultationsTeleconsultation> {
  Future<List<Step>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation_teleconsultation.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Step> steps = [];
      for (var i = 0; i < jsonData.length; i++) {
        steps.add(Step(i + 1, jsonData[i] as String));
      }
      return steps;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDE8C07),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 1, 1)),
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
                    'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/consultation.jpg'),
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
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
    FutureBuilder<List<Step>>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return const Text('Erreur de chargement des données');
    } else if (!snapshot.hasData) {
      return const Text('Aucune donnée disponible');
    } else {
      List<Step> steps = snapshot.data ?? [];
      return Column(
        children: steps.map((step) {
          List<String> parts = step.title.split(':'); // Diviser le texte en parties
          if (parts.length == 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
               
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDE8C07),
                    ),
                    child: Center(
                      child: Text(
                        step.number.toString(),
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${parts[0]}:', // Partie avant le ":"
                            style: const TextStyle(
                              color: Color.fromARGB(255, 138, 86, 3), // Style en rouge
                              fontWeight: FontWeight.bold, // Texte en gras
                            ),
                          ),
                          TextSpan(
                            text: parts[1], // Partie après le ":"
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDE8C07),
                    ),
                    child: Center(
                      child: Text(
                        step.number.toString(),
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      step.title,
                      overflow: TextOverflow.visible, // Texte dépassant le conteneur sera visible
                    ),
                  ),
                ],
              ),
            );
          }
        }).toList(),
      );
    }
  },
),
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
    );
  }
}
