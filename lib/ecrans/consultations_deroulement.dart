import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../bottom_navigation_consultations.dart';

class ConsultationsDeroulement extends StatefulWidget {
  const ConsultationsDeroulement({Key? key}) : super(key: key);

  @override
  ConsultationsDeroulementState createState() =>
      ConsultationsDeroulementState();
}

class ConsultationsDeroulementState extends State<ConsultationsDeroulement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Widget processJson(String jsonValue) {
    int colonIndex = jsonValue.indexOf(':');

    if (colonIndex != -1) {
      String boldText = jsonValue.substring(0, colonIndex + 1);
      String remainingText = jsonValue.substring(colonIndex + 1);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            boldText,
           
            style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
           fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            remainingText,
             textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      );
    } else {
      return Text(
        jsonValue,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      );
    }
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
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_consultation_deroulement.php'));

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
    double containerWidth = MediaQuery.of(context).size.width;
    //double containerHeight = MediaQuery.of(context).size.height;
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDE8C07),
         centerTitle: true,
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
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
              'Déroulement',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.center,
            width: containerWidth,
            child: ClipPath(
              clipper: WaveClipper(), // Utilisation du clipper personnalisé
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/services/deroulement.jpg',
                width: containerWidth,
                height: 200, // Hauteur de l'image
                fit: BoxFit.cover,
              ),
            ),
          ),
        
          const Text(
            'les 7 points principaux',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 7, 7)),
          ),
            const SizedBox(
          height: 30,
          ),
          Container(
          width: containerWidth * 0.8,
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
          const SizedBox(
          height: 10,
          ),
          Expanded(
            child: Container(
                 width: containerWidth*0.8,
                height: 200,
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  7,
                  (index) {
                    String jsonValue =
                        jsonValues.isNotEmpty ? jsonValues[index] : '';

                    return Center(
                      child: Container(
                       // alignment: Alignment.bottomCenter,
                       // color: tabColors[index],
                        child: processJson(jsonValue),
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
