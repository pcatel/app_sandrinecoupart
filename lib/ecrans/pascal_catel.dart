import 'package:flutter/material.dart';
//import '../bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../drawer.dart';

class PascalCatel extends StatefulWidget {
  const PascalCatel({Key? key}) : super(key: key);

  @override
  PascalCatelState createState() => PascalCatelState();
}

class PascalCatelState extends State<PascalCatel> {
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/read_pascal_catel.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<String>();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
   double containerHeight = MediaQuery.of(context).size.height;
   double containerWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     // drawer: const MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF033376),
         centerTitle: true,
        title: const Text(
          'Pascal CATEL',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          const SizedBox(
          height: 20),
          Container(
          
            width: containerHeight*0.3,//Ajustez la largeur du conteneur selon vos besoins
            height: containerHeight*0.3,
            // Ajustez la hauteur du conteneur selon vos besoins
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF033376),
              //border: Border.all(
               // color: Colors.black, // Couleur de la bordure
              //  width: 2.0, // Largeur de la bordure
            //  ),
            ),
            child: ClipOval(
              child: Image.network(
                'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/matete.png',
                width: 300, // Ajustez la largeur de l'image selon vos besoins
                height: 300, // Ajustez la hauteur de l'image selon vos besoins
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
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
                  List<String> dataList =
                      snapshot.data ?? []; // Add this line to handle null data
                  String queryResult =
                      dataList.isNotEmpty ? dataList.join('\n') : '';
                  return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      height: containerHeight*0.4,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              queryResult,
                              style: GoogleFonts.lato(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                                   textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: const Column(
              children: [
                // Votre contenu ici
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
         


              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "https://www.facebook.com/pascal.catel.18/");
                      },
                      child: Image.asset('assets/Reseaux/facebook.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "https://www.instagram.com/pascal.catel.18/");
                      },
                      child: Image.asset('assets/Reseaux/instagram.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "https://www.tiktok.com/@pascalcatel");
                      },
                      child: Image.asset('assets/Reseaux/tiktok.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "https://www.linkedin.com/in/pascal-catel-2215a043/");
                      },
                      child: Image.asset('assets/Reseaux/linkedin.png'),
                    ),
                     GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "http://www.pascalcatel.com/catelblog/");
                      },
                      child: Image.asset('assets/Reseaux/site_web.jpg'),
                    ),
                     GestureDetector(
                      onTap: () {
                        _launchAppOrBrowser(
                            "https://github.com/pcatel");
                      },
                      child: Image.asset('assets/Reseaux/github.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PascalCatel()));
                  },
                  child: const Text(
                    'Powered by : Pascal CATEL',
                    style: TextStyle(
                      fontSize: 26,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
     // bottomNavigationBar:
        //  const BottomNavigationBarScreen(backgroundColor: Color(0xFF033376)),
    );
  }

  Future<void> _launchAppOrBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(uri);
    }
  }
}
