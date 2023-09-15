import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'fiche_recette.dart';
import '../bottom_navigation_recettes.dart';

class ListeRecettesTypesPlats extends StatefulWidget {
  final String idCategorie;
  final String nomCategorie;

  const ListeRecettesTypesPlats({
    Key? key,
    required this.idCategorie,
    required this.nomCategorie,
  }) : super(key: key);

  @override
  ListeRecettesTypesPlatsState createState() => ListeRecettesTypesPlatsState();
}

class ListeRecettesTypesPlatsState extends State<ListeRecettesTypesPlats> {
  List<Recette> recettes = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    // Appeler la fonction pour charger les recettes dans initState
    loadRecettes();
  }

  Future<void> loadRecettes() async {
    try {
      // Construire l'URL avec idCategorie comme paramètre
      final url = Uri.parse(
          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/liste_recettes_types_plats.php?idCategorie=${widget.idCategorie}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Recette> loadedRecettes = [];
        for (var item in jsonData) {
          loadedRecettes.add(
            Recette(
              nom: item['NomRecette'],
              idRecette: item['IdRecette'],
              categorie: item['categorieRecette'],
            ),
          );
        }
        // Mettez à jour l'état avec les données chargées
        setState(() {
          recettes = loadedRecettes;
          isLoading = false; // Le chargement est terminé
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Gérer les erreurs ici
      //print(e);
      setState(() {
        isLoading = false; // Le chargement est terminé
        error = 'Erreur de chargement des recettes';
      });
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
      body: isLoading
          ? _buildLoadingIndicator()
          : error != null
              ? _buildErrorWidget()
              : Container(
              alignment: Alignment.center,
      //height: containerHeight,
      width:double.infinity,
                child: Column(
                    children: [
                      _buildHeader(),
                      _buildImageWithWaveClipper(), // Utilisation de WaveClipper pour l'image
                      Text(
                        widget.nomCategorie,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                        width:double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('categorie',style: TextStyle(fontSize: 18),)),
                                 DataColumn(label: Text('recette',style: TextStyle(fontSize: 18),)),
                              ],
                              rows: recettes
                                  .map(
                                    (recette) => DataRow(
                                      cells: [
                                        DataCell(Text(recette.categorie,style: const TextStyle(fontSize: 18))),
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              // Naviguer vers la page FicheRecette
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FicheRecette(
                                                    idRecette: recette.idRecette,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(recette.nom,style: const TextStyle(fontSize: 18)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF9C27B0),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text(error!),
    );
  }

  Widget _buildHeader() {
    double containerHeight = MediaQuery.of(context).size.height * 0.15;
    double containerWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: containerHeight,
      width: containerWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(
              'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0xFF9C27B0),
            BlendMode.color,
          ),
        ),
      ),
      child: const Text(
        'Recettes',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }

  Widget _buildImageWithWaveClipper() {
    double containerWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: containerWidth,
      child: ClipPath(
        clipper: WaveClipper(), // Utilisation du clipper personnalisé
        child: Image.network(
          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/types_plats/${widget.idCategorie}.jpg',
          width: containerWidth,
          height: 300, // Hauteur de l'image
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Recette {
  final String nom;
  final String idRecette;
  final String categorie;

  Recette({
    required this.nom,
    required this.idRecette,
    required this.categorie,
  });
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
