import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import '../bottom_navigation_recettes.dart';
import 'menus_semaine.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  MenusState createState() => MenusState();
}

class MenusState extends State<Menus> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_menus.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double textContainerHeight = containerHeight * 1.5;

    double containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C27B0),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 1, 1)),
        ),
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligne les enfants en haut

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
              'Menus',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              height: textContainerHeight,
              width: containerWidth,
              //color: Colors.red, // Couleur du container rouge
              child: FutureBuilder<List<String>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erreur de chargement des données');
                  } else if (!snapshot.hasData) {
                    return const Text('Aucune donnée disponible');
                  } else {
                    List<String> dataList = snapshot.data ??
                        []; // Add this line to handle null data
                    String queryResult = dataList.join('\n');
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          queryResult,
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuSemaine("1"),
                      ),
                    );
                  },
                  child: Container(
                    width: containerWidth * 0.3,
                    height: containerHeight * 0.6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9C27B0),
                      borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/les_recettes/semaine.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: const Text(
                          'Semaine 1',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color(0xFF9C27B0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuSemaine("2"),
                      ),
                    );
                  },
                  child: Container(
                    width: containerWidth * 0.3,
                    height: containerHeight * 0.6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9C27B0),
                      borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/les_recettes/semaine.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: const Text(
                          'Semaine 2',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color(0xFF9C27B0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
          height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuSemaine("3"),
                      ),
                    );
                  },
                  child: Container(
                    width: containerWidth * 0.3,
                    height: containerHeight * 0.6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9C27B0),
                      borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/les_recettes/semaine.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: const Text(
                          'Semaine 3',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color(0xFF9C27B0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuSemaine("4"),
                      ),
                    );
                  },
                  child: Container(
                    width: containerWidth * 0.3,
                    height: containerHeight * 0.6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9C27B0),
                      borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/les_recettes/semaine.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: const Text(
                          'Semaine 4',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            backgroundColor: Color(0xFF9C27B0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFF9C27B0)),
    );
  }
}
