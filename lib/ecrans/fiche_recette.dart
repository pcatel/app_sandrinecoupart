import 'package:flutter/material.dart';
import '../bottom_navigation_recettes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FicheRecette extends StatefulWidget {
  final String idRecette;

  const FicheRecette({Key? key, required this.idRecette}) : super(key: key);

  @override
  FicheRecetteState createState() => FicheRecetteState();
}

class FicheRecetteState extends State<FicheRecette> {
  Map<String, dynamic>? recetteData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    // Appeler la fonction pour charger les détails de la recette dans initState
    loadRecetteDetails();
  }

  Future<void> loadRecetteDetails() async {
    try {
      // Construire l'URL avec idRecette comme paramètre
      final url = Uri.parse(
          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/fiche_recette.php?idRecette=${widget.idRecette}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          recetteData =
              jsonData[0]; // Prendre le premier élément du tableau JSON
          isLoading = false; // Le chargement est terminé
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Gérer les erreurs ici
      setState(() {
        isLoading = false; // Le chargement est terminé
        error = 'Erreur de chargement de la recette';
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
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: isLoading
          ? _buildLoadingIndicator()
          : error != null
              ? _buildErrorWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildImageContainer(),
                      _buildFicheRecette(),
                    ],
                  ),
                ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF9C27B0),
      ),
    );
  }

  Widget _buildImageContainer() {
    double containerHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width;

    // Construisez l'URL de la première image basée sur IdRecette.jpg
    const imageUrl =
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes.jpg';

    return Container(
      alignment: Alignment.center,
      height: containerHeight * 0.1,
      width: containerWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image:
              NetworkImage(imageUrl), // Chargez la première image depuis l'URL
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
            color: Color.fromARGB(255, 252, 251, 251)),
      ),
    );
  }

  Widget _buildFicheRecette() {
    double containerHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width;
    final imageUrl =
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes/${widget.idRecette}.jpg';

    return Column(
      children: [
        // Deuxième image pour la photo de la recette (afficher en plein écran)
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        //<-- SEE HERE
                        width: 10,color: Colors.white,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: _buildRecetteImage(),
        ),

        // Les détails de la recette

        Container(
          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF45114E),
          ),
          child: Text(
            '${recetteData?['categorie']} ==> ${recetteData?['titre']}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          // les temps
          height: containerHeight * 0.05,
          decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                ),
          child: Column(
            children: [
              Container(
                width: containerWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                ),
                child: Text(
                  'Temps de préparation : ${recetteData?['temps_preparation']} minutes',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: containerWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                ),
                child: Text(
                  'Temps de repos : ${recetteData?['temps_repos']} minutes',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: containerWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFF9C27B0),
                ),
                child: Text(
                  'Temps de cuisson : ${recetteData?['temps_cuisson']} minutes',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
        ),
        Container(
          // les ingredients

          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF45114E),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Ingrédients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ), // Ajustez la taille de police selon vos besoins
                ),
              ),
            ],
          ),
        ),
        Container(
          height: containerHeight * 0.2,
          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
          child: Text(
            '${recetteData?['ingredients']}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: 1,
        ),
        Container(
          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF45114E),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Etapes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ), // Ajustez la taille de police selon vos besoins
                ),
              ),
            ],
          ),
        ),
        Container(
          height: containerHeight * 0.2,
          width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
          child: Text(
            ' ${recetteData?['etapes']}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildRecetteImage() {
    double containerHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width;
    final imageUrl =
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes/${widget.idRecette}.jpg';

    return Stack(
      children: [
        Container(
          height: containerHeight * 0.4,
          width: containerWidth,
          color: Colors.grey, // Couleur de fond de l'image
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: containerHeight * 0.4,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Couleur de la bordure
              width: 2.0, // Largeur de la bordure
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF9C27B0)
                .withOpacity(0.5), // Couleur d'arrière-plan du texte
            child: const Text(
              'Zoomer',
              style: TextStyle(
                color: Colors.white, // Couleur du texte
                fontSize: 16.0, // Taille du texte
              ),
            ),
          ),
        ),
      ],
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
