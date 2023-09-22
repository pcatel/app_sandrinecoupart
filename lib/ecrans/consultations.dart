import 'package:flutter/material.dart';
import '../bottom_navigation_consultations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'consultations_consultations.dart';
import 'consultations_deroulement.dart';
import 'consultations_teleconsultations.dart';
import 'consultations_relations_mutuelle.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drawer.dart';

class Consultations extends StatefulWidget {
  const Consultations({super.key});

  @override
  ConsultationsState createState() => ConsultationsState();
}

class ConsultationsState extends State<Consultations> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation.php'));

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
    //double textContainerHeight = containerHeight * 1.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MyDrawerWidget(),
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
        mainAxisAlignment: MainAxisAlignment.start,
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
                    'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/consultation.jpg'),
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
          const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.center,
            width: containerWidth,
            child: ClipPath(
              clipper: WaveClipper(), // Utilisation du clipper personnalisé
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/consultation.jpg',
                width: containerWidth,
                height: 300, // Hauteur de l'image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
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
                  List<String> dataList =
                      snapshot.data ?? []; // Add this line to handle null data
                  String queryResult = dataList.join('\n');
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        queryResult,
                        
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                             textAlign: TextAlign.justify,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ConsultationsConsultations()));
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: containerWidth / 2,
                        height: containerHeight,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/service-5.jpg'),
                            fit: BoxFit.cover,
                            //colorFilter: ColorFilter.mode(
                            // Color(0xFFDE8C07),
                            //   BlendMode.color,
                            // ),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          color: const Color(0xFFDDB474),
                          child: const Text(
                            'Consultations',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 7, 7),
                              //backgroundColor:Colors.white,
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
                                builder: (context) =>
                                    const ConsultationsDeroulement()));
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
                            //colorFilter: ColorFilter.mode(
                            // Color(0xFFDE8C07),
                            //   BlendMode.color,
                            // ),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          color: const Color(0xFFDDB474),
                          child: const Text(
                            'Déroulement',
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
              ],
            ),
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
                            builder: (context) =>
                                const ConsultationsTeleconsultation()));
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
                        //colorFilter: ColorFilter.mode(
                        // Color(0xFFDE8C07),
                        //   BlendMode.color,
                        // ),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: double.infinity,
                      color: const Color(0xFFDDB474),
                      child: const Text(
                        'Téléconsultations',
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
                            builder: (context) =>
                                const ConsultationsMutuelle()));
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: containerWidth / 2,
                    height: containerHeight,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/relation_mutuelle.jpg'),
                        fit: BoxFit.cover,
                        //colorFilter: ColorFilter.mode(
                        // Color(0xFFCFB17F),
                        //   BlendMode.color,
                        // ),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: double.infinity,
                      color: const Color(0xFFDDB474),
                      child: const Text(
                        'Relations Mutuelle',
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
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
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
