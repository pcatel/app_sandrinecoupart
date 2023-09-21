import 'package:flutter/material.dart';
import 'ecrans/consultations.dart';
import 'ecrans/ateliers_prevention.dart';
import 'ecrans/infos_nutrition.dart';
import 'ecrans/recettes.dart';
import 'ecrans/temoignages.dart';
import 'ecrans/contacts.dart';
import 'ecrans/presentation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ecrans/pascal_catel.dart';

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
    double containerHeight = MediaQuery.of(context).size.height;
    //double hauteurEntreModule = 10;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5, // largeur du drawer
      child: Container(
        color: const Color(0xFF609a7d),
        child: Column(
          children: [
            // En-tête avec 20% de l'espace
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Presentation()),
                );
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  // header drawer
                  height: containerHeight * 0.3,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFFdc9a7d),
                    ),
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Color(0xFFdc9a7d)),
                      accountName: Text(
                        "Sandrine COUPART",
                        style: TextStyle(
                            color: Color(0xFF00353F),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        "Diététicienne - Nutritionniste",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF430C05),
                            fontWeight: FontWeight.bold),
                      ),
                      currentAccountPictureSize: Size.square(200),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/nutritionniste.jpg'),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Liste des éléments ListTile avec 60% de l'espace
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: containerHeight * 0.6,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Consultations()));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // R// Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Consultations',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AtelierPrevention()));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // R// Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Ateliers prévention',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InfosNutrition()));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Infos nutrition',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Recettes()));
                        },
                         child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // R// Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Recettes',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Temoignages()));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // R// Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Témoignages',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Contacts()));
                        },
                        child: const Row(
                        
                          children: [
                            Icon(
                              Icons
                                  .arrow_circle_down, // R// Remplacez "votre_icone" par l'icône que vous souhaitez utiliser
                              color: Colors.white, // Couleur de l'icône
                            ),
                            SizedBox(
                                width: 8.0), // Espace entre l'icône et le texte
                            Text(
                              'Contacts',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //const Spacer(), // Ajout d'un Spacer pour pousser les éléments suivants vers le bas

                // Ligne des réseaux sociaux avec 20% de l'espace
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
          ],
        ),
      ),
    );
  }
}
