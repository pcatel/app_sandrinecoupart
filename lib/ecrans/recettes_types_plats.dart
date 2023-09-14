import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'liste_recettes_types_plats.dart';
import '../bottom_navigation.dart';

class RecettesTypesPlats extends StatefulWidget {
  const RecettesTypesPlats({Key? key}) : super(key: key);

  @override
  RecettesTypesPlatsState createState() => RecettesTypesPlatsState();
}

class RecettesTypesPlatsState extends State<RecettesTypesPlats> {
  Future<List<String>> fetchMutuelleData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_recettes_types_plats.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Map<String, String>>> fetchCommentairesData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_categories.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Map<String, String>> data = [];
      for (var item in jsonData) {
        data.add({
          "NomCategorie": item['NomCategorie'],
          "IdCategorie": item['IdCategorie'],
          "NbreRecettes": item['NbreRecettes']
        });
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C27B0),
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
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFF9C27B0),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Recettes par types de plats',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
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
                  return GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
  ),
  itemCount: dataList.length,
  itemBuilder: (BuildContext context, int index) {
    String nomCategorie = dataList[index]['NomCategorie'] ?? '';
    String nbreRecettes = dataList[index]['NbreRecettes'] ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListeRecettesTypesPlats(
              idCategorie: dataList[index]['IdCategorie']!,
              nomCategorie: dataList[index]['NomCategorie']!,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0xFFDA93E7),
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/types_plats/${dataList[index]['IdCategorie']}.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$nomCategorie ($nbreRecettes)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);


                }
              },
            ),
          ),
        ],
      ),
       bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF9C27B0),
      ),
    );
  }
}