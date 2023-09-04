import 'package:flutter/material.dart';
import 'ecrans/consultations.dart';
import 'ecrans/ateliers_prevention.dart';
import 'ecrans/infos_nutrition.dart';
import 'ecrans/recettes.dart';
import 'ecrans/temoignages.dart';
import 'ecrans/contacts.dart';
import 'ecrans/presentation.dart';
import 'ecrans/test.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);
  Future<void> _launchAppOrBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        color: const Color(0xFF609a7d),
        child: Column(
          children: [
            // En-tête avec 20% de l'espace
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Presentation()),
                  );
                },
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFFdc9a7d),
                  ),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFFdc9a7d)),
                    accountName: Row(
                 
                    //crossAxisAlignment: CrossAxisAlignment.center,
                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Sandrine COUPART",
                          style: TextStyle(
                              color: Color(0xFF00353F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    accountEmail: Row(
                 
                      children: [
                        Text(
                          "Diététicienne - Nutritionniste",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF430C05),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    currentAccountPictureSize: Size.square(120),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/nutritionniste.jpg'),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            // Liste des éléments ListTile avec 60% de l'espace

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFDE8C07),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Consultations",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Consultations()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9800),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Ateliers prévention",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AtelierPrevention()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Infos nutrition",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InfosNutrition()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF9C27B0),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Recettes",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Recettes()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF795548),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Témoignages",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Temoignages()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE91E63),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Contacts",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Contacts()),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE91E63),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          title: const Text(
                            "Test",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1e1e1e),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyList()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Ligne des réseaux sociaux avec 20% de l'espace
                Container(
                  //height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                    ],
                  ),
                ),
                Container(
                  child: const Text(
                    'Powered by : Pascal CATEL', // Utilisez numberOfItems ici
                    style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                ),
              ],
            ),
            // Ligne des réseaux sociaux avec 20% de l'espace
          ],
        ),
      ),
    );
  }
}
