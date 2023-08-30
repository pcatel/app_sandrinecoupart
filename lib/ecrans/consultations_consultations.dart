import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_navigation.dart';

class Ecran9 extends StatefulWidget {
  const Ecran9({Key? key}) : super(key: key);

  @override
  Ecran9State createState() => Ecran9State();
}

class Ecran9State extends State<Ecran9> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Color> tabColors = [
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
    const Color(0xFFF0D2A3),
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
  ];

  List<String> jsonData = [];
  List<String> jsonValues = []; // New list to store JSON values

  @override
 void initState() {
  super.initState(); // Appelez super.initState() ici

  fetchData().then((_) {
    setState(() {
      _tabController = TabController(length: 7, vsync: this);
    });
  });

}

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation_consultation.php'));

    if (response.statusCode == 200) {
      List<dynamic> parsedData = json.decode(response.body);
      jsonData = parsedData.cast<String>();

      // Store JSON values in the new list
      jsonValues.addAll(jsonData);
    } else {
      throw Exception('Failed to load data');
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 150, // Adjust the height as needed
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                    'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/consultation.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFFDE8C07),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Les consultations',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 249, 223, 181),
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                color: Color(0xFFDE8C07),
              ),
              labelColor: Colors.black,
              tabs: List.generate(
                7,
                (index) => Tab(
                  text: '${index + 1}',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  7,
                  (index) {
                    // Récupérer la valeur JSON pour l'onglet actuel
                    String jsonValue = jsonValues.isNotEmpty ? jsonValues[index] : 'toto';

                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: tabColors[index],
                        child: Text(
                          jsonValue, // Afficher le contenu JSON pour l'onglet actuel
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFFDE8C07),
      ),
    );
  }
}
