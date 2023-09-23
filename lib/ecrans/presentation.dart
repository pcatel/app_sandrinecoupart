import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../home_screen.dart'; // Assurez-vous que le chemin est correct
import 'package:google_fonts/google_fonts.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  PresentationState createState() => PresentationState();
}

class PresentationState extends State<Presentation> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_presentation.php'));

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
        backgroundColor: const Color(0xFF609a7d),
        centerTitle: true,
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 251, 251, 251),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(
                height: 20,
                ),
                  Container(
                    // Votre code pour l'image ici
                    margin: const EdgeInsets.only(top: 1),
                    child: ClipOval(
                      child: Container(
                        width: 300, // Largeur de l'image
                        height: 200, // Hauteur de l'image
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Couleur de la bordure
                            width: 2.0, // Largeur de la bordure
                          ),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/nutritionniste.jpg'), // Remplacez par l'URL de votre image
                            fit: BoxFit
                                .cover, // Ajustement de l'image pour remplir le cercle
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Container(
                    // Votre code pour le premier ListTile ici
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      title: Text(
                        snapshot.data?[0] ?? '',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Appliquez ici les styles que vous souhaitez
                    ),
                  ),
                  Container(
                    // Votre code pour le deuxième ListTile ici
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      title: Text(
                        snapshot.data?[1] ?? '',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Appliquez ici les styles que vous souhaitez
                    ),
                  ),
                  Container(
                    // Votre code pour le troisième ListTile ici
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      title: Text(
                        snapshot.data?[2] ?? '',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Appliquez ici les styles que vous souhaitez
                    ),
                  ),
                  Container(
                    // Votre code pour le quatrième ListTile ici
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      title: Text(
                        snapshot.data?[3] ?? '',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Appliquez ici les styles que vous souhaitez
                    ),
                  ),
                  const SizedBox(height: 1),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      // Votre code pour le bouton Bienvenue ici
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
      ),
    );
  }
}
