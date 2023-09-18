import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_navigation_recettes.dart';
import 'menu_model.dart';

class MenuSemaine extends StatefulWidget {
  final String semaine;

  const MenuSemaine(this.semaine, {super.key});

  @override
  MenuSemaineState createState() => MenuSemaineState();
}

class MenuSemaineState extends State<MenuSemaine> {
  List<MenuModel> menus = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchMenuData(widget.semaine);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

        setState(() {});
      } else {
        // Gérer les erreurs de requête HTTP
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou de traitement JSON
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles =
        menus.map((menu) => "Jour ${menu.jour}").toList();

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
              height: 200,
              width: double.infinity,
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
              'Semaine ${widget.semaine}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        color: Colors.white, // Fond blanc
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            if (_pageController.hasClients) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100, // Ajustez la largeur selon vos préférences
                          child: Card(
                            margin: const EdgeInsets.all(4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: const Color(0xFF9C27B0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 200,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/jour.png',
                                      ),
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFF9C27B0),
                                        BlendMode.color,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    titles[index],
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Petit déjeuner',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      menus[index].petitDejeuner,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Déjeuner',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      menus[index].dejeuner,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Collation',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      menus[index].collation,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Dîner',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      menus[index].diner,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white, // Fond blanc
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (_pageController.hasClients) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(backgroundColor: Color(0xFF9C27B0)),
    );
  }
}
