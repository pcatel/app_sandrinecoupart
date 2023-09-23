import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import '../bottom_navigation.dart';
import '../drawer.dart';

void main() {
  runApp(const MaterialApp(
    home: InfosNutrition(),
  ));
}

class InfosNutrition extends StatefulWidget {
  const InfosNutrition({Key? key}) : super(key: key);

  @override
  InfosNutritionState createState() => InfosNutritionState();
}

class InfosNutritionState extends State<InfosNutrition> {
  int numberOfItems = 0; // Variable pour stocker le nombre d'éléments JSON

  List<Widget> buildCardsFromJson() {
    List<Widget> cards = [];

    for (var i = 0; i < jsonValues.length; i++) {
      String jsonValue = jsonValues[i];
      int colonIndex = jsonValue.indexOf(':');

      if (colonIndex != -1) {
        String title = jsonValue.substring(0, colonIndex).trim();
        String subtitle = jsonValue.substring(colonIndex + 1).trim();
        String imageUrl =
            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/infos_nutrition/$i.jpg';

        cards.add(
          CustomCard(
            title: title,
            subtitle: subtitle,
            imageUrl: imageUrl,
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
        // Récupérer le nombre d'éléments JSON
        numberOfItems = jsonValues.length;
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
    drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
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
              'Infos nutrition', // Utilisez numberOfItems ici
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          Text(
            'Les $numberOfItems principes fondamenteaux', // Utilisez numberOfItems ici
            style: const TextStyle(
                fontSize: 18,
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
      height: 200,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 10,
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  const Color(0xFF2196F3).withOpacity(0.3),
                  BlendMode.srcATop,
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover, // Utilisez BoxFit.cover pour remplir entièrement la carte
                  width: double.infinity, // Ajustez la largeur pour remplir la carte
                  height: double.infinity, 
                  placeholder: (context, url) => const PlaceholderImage(),
                  errorWidget: (context, url, error) => const ErrorIndicator(),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                   //  color: Color.fromRGBO(52, 145, 238, 0.498),
                     color:Colors.blue,
                    ),
                    child: ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(fontSize: 30.0,
                        color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        subtitle,
                        style: const TextStyle(fontSize: 14.0,
                        color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
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

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 48.0,
      ),
    );
  }
}
