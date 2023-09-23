import 'package:flutter/material.dart';
import '../bottom_navigation_consultations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class ConsultationsMutuelle extends StatefulWidget {
  const ConsultationsMutuelle({Key? key}) : super(key: key);

  @override
  ConsultationsMutuelleState createState() => ConsultationsMutuelleState();
}

class ConsultationsMutuelleState extends State<ConsultationsMutuelle> {
  Future<List<String>> fetchMutuelleData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation_Mutuelle.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Map<String, String>>> fetchCommentairesData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_mutuelle.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Map<String, String>> data = [];
      for (var item in jsonData) {
        data.add(
            {"Mutuelle": item['Mutuelle'], "Commentaire": item['Commentaire']});
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
   double containerWidth = MediaQuery.of(context).size.width;
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
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/consultation.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFFDE8C07),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Relations Mutuelles',
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
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/relation_mutuelle.jpg',
                width: containerWidth,
                height: 200, // Hauteur de l'image
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<String>>(
            future: fetchMutuelleData(),
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
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<Map<String, String>>>(
                future: fetchCommentairesData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erreur de chargement des données');
                  } else if (!snapshot.hasData) {
                    return const Text('Aucune donnée disponible');
                  } else {
                    List<Map<String, String>> dataList = snapshot.data ?? [];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xFFDE8C07)),
                            columns: const [
                              DataColumn(label: Text('Mutuelle')),
                              DataColumn(label: Text('Commentaire')),
                            ],
                            rows: dataList.map((data) {
                              return DataRow(cells: [
                                DataCell(SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(data['Mutuelle'] ?? ''),
                                )),
                                DataCell(SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(data['Commentaire'] ?? ''),
                                )),
                              ]);
                            }).toList(),
                          ),
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