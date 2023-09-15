import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_navigation.dart';
import 'menu_model.dart';

class MenuSemaine extends StatefulWidget {
  final String semaine;

  const MenuSemaine(this.semaine, {super.key});

  @override
  MenuSemaineState createState() => MenuSemaineState();
}

class MenuSemaineState extends State<MenuSemaine> {
  List<MenuModel> menus = [];

  @override
  void initState() {
    super.initState();
    fetchMenuData(
        widget.semaine); // Appel de la fonction pour récupérer les données JSON
  }

  Future<void> fetchMenuData(String semaine) async {
    final url = Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_semaine.php?semaine=$semaine');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        menus = jsonData.map((data) {
          return MenuModel(
            semaine: data['semaine'],
            jour: data['jour'],
            petitDejeuner: data['petit_dejeuner'],
            dejeuner: data['dejeuner'],
            collation: data['collation'],
            diner: data['diner'],
          );
        }).toList();

        setState(() {
          // Mettez à jour l'interface utilisateur avec les données JSON
        });
      } else {
        // Gérer les erreurs de requête HTTP
        //print('Erreur de requête HTTP : ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou de traitement JSON
      // print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles =
        menus.map((menu) => "Jour ${menu.jour}").toList();
    final List<Widget> images = List.generate(
      titles.length,
      (index) => Card(
        margin: const EdgeInsets.only(left: 2, right: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: const Color(0xFF9C27B0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Petit déjeuner: \n  ${menus[index].petitDejeuner}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Déjeuner: \n ${menus[index].dejeuner}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              'Collation: \n  ${menus[index].collation}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              'Dîner: \n ${menus[index].diner}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );

    double containerHeight =
        800; // Définissez la hauteur souhaitée du conteneur
    //double containerWidth = double.infinity; // Vous pouvez ajuster la largeur comme vous le souhaitez
    double containerWidth = MediaQuery.of(context).size.width;
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: containerHeight * 0.2,
              width: containerWidth,
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
                'Menus',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Text(
              'Semaine ${widget.semaine}', // Ajoutez le texte avec la semaine
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            Expanded(
              child: Card(
                child: VerticalCardPager(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  titles: titles,
                  images: images,
                  onPageChanged: (page) {
                    // print(page);
                  },
                  onSelectedItem: (index) {
                    // Gérer la sélection d'une carte
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFF9C27B0)),
    );
  }
}
