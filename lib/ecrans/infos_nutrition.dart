import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_navigation.dart';

class InfosNutrition extends StatefulWidget {
  const InfosNutrition({Key? key}) : super(key: key);

  @override
  InfosNutritionState createState() => InfosNutritionState();
}

class InfosNutritionState extends State<InfosNutrition> {
  List<Widget> buildCardsFromJson() {
    List<Widget> cards = [];

    for (var jsonValue in jsonValues) {
      int colonIndex = jsonValue.indexOf(':');

      if (colonIndex != -1) {
        String title = jsonValue.substring(0, colonIndex).trim();
        String subtitle = jsonValue.substring(colonIndex + 1).trim();

        cards.add(
          CustomCard(
            title: title,
            subtitle: subtitle,
            imageUrl:
                'URL_IMAGE', // Remplacez 'URL_IMAGE' par l'URL de votre image en ligne
          ),
        );
      }
    }

    return cards;
  }

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
  List<String> jsonValues = [];

  @override
  void initState() {
    super.initState();

    fetchData().then((_) {
      setState(() {
        //_tabController = TabController(length: 7, vsync: this);
      });
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_infos_nutrition.php'));

    if (response.statusCode == 200) {
      List<dynamic> parsedData = json.decode(response.body);
      jsonData = parsedData.cast<String>();
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
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                    'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/infos_nutrition.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFF2196F3),
                  BlendMode.color,
                ),
              ),
            ),
            child: const Text(
              'Déroulement',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          const Text(
            'les 7 points principaux',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 7, 7)),
          ),
          Expanded(
            child: ListView(
              children: buildCardsFromJson(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFF2196F3),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 200,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.orange,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 56,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.green,
                  size: 60.0,
                ),
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 30.0),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    child: const Text('Se connecter'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
