import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../home_screen.dart'; // Assurez-vous que le chemin est correct

class Ecran13 extends StatefulWidget {
  @override
  _Ecran13State createState() => _Ecran13State();
}

class _Ecran13State extends State<Ecran13> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecran 13'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue, // Couleur de fond
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16), // Espace entre l'image et les containers
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(16.0), // Espace autour du container
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Couleur de fond
                          borderRadius: BorderRadius.circular(10.0), // Bordures arrondies
                        ),
                        child: ListTile(
                          title: Text(snapshot.data?[index] ?? ''),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Center(
                      child: Text(
                        'Bienvenue',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Ecran13()));
