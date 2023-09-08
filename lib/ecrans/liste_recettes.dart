import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListeRecettes extends StatefulWidget {
  final String IdAllergie;
  final String NomAllergie;

  const ListeRecettes({required this.IdAllergie, required this.NomAllergie});

  @override
  ListeRecettesState createState() => ListeRecettesState();
}

class ListeRecettesState extends State<ListeRecettes> {
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
      // Construire l'URL avec IdAllergie comme paramètre
      final url = Uri.parse(
          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/liste_recettes.php?IdAllergie=${widget.IdAllergie}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Recette> loadedRecettes = [];
        for (var item in jsonData) {
          loadedRecettes.add(
              Recette(nom: item['NomRecette'], idRecette: item['IdRecette']));
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
    double containerHeight = MediaQuery.of(context).size.height * 0.15;
    double containerWidth = MediaQuery.of(context).size.width;
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
      body: isLoading
          ? _buildLoadingIndicator()
          : error != null
              ? _buildErrorWidget()
              : Column(
                  children: [
                    Container(
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
                            color: Color.fromARGB(255, 7, 7, 7)),
                      ),
                    ),
                    Container(
alignment: Alignment.center,
                      height: containerHeight,
                      width: containerWidth,


                      child: Image.network(
                      'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/allergies/${widget.IdAllergie}.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    ),
                    Text(
                      widget.NomAllergie,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Id')),
                            DataColumn(label: Text('Recette')),
                          ],
                          rows: recettes
                              .map(
                                (recette) => DataRow(
                                  cells: [
                                    DataCell(Text(recette.idRecette)),
                                    DataCell(Text(recette.nom)),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF795548),
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
}

class Recette {
  final String nom;
  final String idRecette;

  Recette({required this.nom, required this.idRecette});
}
