import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
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
        backgroundColor: const Color(0xFF609a7d),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 1, 1)),
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
    double containerHeight = MediaQuery.of(context).size.height * 0.15;
    double containerWidth = MediaQuery.of(context).size.width;

    // Construisez l'URL de la première image basée sur IdRecette.jpg
    const imageUrl =
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes.jpg';

    return Container(
      alignment: Alignment.center,
      height: containerHeight,
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
            color: Color(0xFFFFFEFE)),
      ),
    );
  }

  Widget _buildFicheRecette() {
    return Column(
      children: [
        // Deuxième image pour la photo de la recette
        _buildRecetteImage(),

        // Les détails de la recette
        Container(
          //width: containerWidth,
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
          child: Text(
            '${recetteData?['titre']}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          width: 600,
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
          child: Text(
            'Temps de préparation : ${recetteData?['temps_preparation']} minutes',
            style: const TextStyle(
              fontSize: 14,
                color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),

        Container(
          width: 600,
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
          child: Text(
            'Temps de repos : ${recetteData?['temps_repos']} minutes',
            style: const TextStyle(
              fontSize: 14,
                color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),

        Container(
          width: 600,
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

        Container(
        
          child:Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes/ingredients.png',
                  width: 25.0, // Ajustez la largeur de l'image selon vos besoins
                  height: 25.0, // Ajustez la hauteur de l'image selon vos besoins
                ),
              ),
              SizedBox(width: 16.0), // Espacement entre l'image et le texte
              Expanded(
                flex: 2,
                child: Text(
                  'Ingrédients',
                  style: TextStyle(fontSize: 18.0), // Ajustez la taille de police selon vos besoins
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 600,
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
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes/etapes.png',
                  width: 25.0, // Ajustez la largeur de l'image selon vos besoins
                  height: 25.0, // Ajustez la hauteur de l'image selon vos besoins
                ),
              ),
              SizedBox(width: 16.0), // Espacement entre l'image et le texte
              Expanded(
                flex: 2,
                child: Text(
                  'Etapes',
                  style: TextStyle(fontSize: 18.0), // Ajustez la taille de police selon vos besoins
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 600,
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
    // Construisez l'URL de la deuxième image basée sur IdRecette.jpg
    final imageUrl =
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/recettes/${widget.idRecette}.jpg';

    return Container(
      height: 200, // Ajustez la hauteur selon vos besoins
      width: double.infinity, // Prend toute la largeur disponible
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              NetworkImage(imageUrl), // Chargez la deuxième image depuis l'URL
          fit: BoxFit.cover,
        ),
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
