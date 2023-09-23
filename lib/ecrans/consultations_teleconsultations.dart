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
  ConsultationsTeleconsultationState createState() =>
      ConsultationsTeleconsultationState();
}

class ConsultationsTeleconsultationState
    extends State<ConsultationsTeleconsultation> {
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
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = MediaQuery.of(context).size.height / 6; // Hauteur du conteneur en fonction de la taille de l'écran

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDE8C07),
        centerTitle: true,
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 18,
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
          const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.center,
            width: containerWidth,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/teleconsultation.jpg',
                width: containerWidth,
                height: 200,
                fit: BoxFit.cover,
              ),
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
                return Expanded(
                  child: ListView(
                    children: steps.map((step) {
                      List<String> parts = step.title.split(':');
                      if (parts.length == 2) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            child: Container(
                              width: containerWidth * 0.8,
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
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        textAlign: TextAlign.justify,
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
                                            text: '${parts[0]}:',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 138, 86, 3),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: parts[1],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  step.title,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }).toList(),
                  ),
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

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 4, size.height * 0.9, size.width / 2, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 0.7, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
