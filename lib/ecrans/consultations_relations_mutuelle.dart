import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ecran12 extends StatefulWidget {
  const Ecran12({Key? key}) : super(key: key);

  @override
  Ecran12State createState() => Ecran12State();
}

class Ecran12State extends State<Ecran12> {
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
        data.add({"Mutuelle": item['Mutuelle'], "Commentaire": item['Commentaire']});
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double columnWidth = MediaQuery.of(context).size.width / 2;

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
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: columnWidth,
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
          const SizedBox(height: 20),
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      queryResult,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Map<String, String>>>(
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
                  child: DataTable(
                    columns: [
                      DataColumn(label: SizedBox(width: columnWidth, child: const Text('Mutuelle'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: const Text('Commentaire'))),
                    ],
                    rows: dataList.map((data) {
                      return DataRow(cells: [
                        DataCell(SizedBox(width: columnWidth, child: Text(data['Mutuelle'] ?? ''))),
                        DataCell(SizedBox(width: columnWidth, child: Text(data['Commentaire'] ?? ''))),
                      ]);
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
    );
  }
}
