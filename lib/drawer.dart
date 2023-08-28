import 'package:flutter/material.dart';
import 'ecrans/consultations.dart';
import 'ecrans/ateliers_prevention.dart';
import 'ecrans/infos_nutrition.dart';
import 'ecrans/recettes.dart';
import 'ecrans/temoignages.dart';
import 'ecrans/contacts.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

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
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFdc9a7d),
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFFdc9a7d)),
                  accountName: Row(
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
                  currentAccountPictureSize: Size.square(100),
                  currentAccountPicture: CircleAvatar(
                    //backgroundImage: AssetImage('assets/images/matete.png'),
                    backgroundImage: NetworkImage(
                        'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/nutritionniste.jpg'),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran1()),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran2()),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran3()),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran4()),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran5()),
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
                          visualDensity:
                              const VisualDensity(vertical: -4), // to compact

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
                                  builder: (context) => const Ecran6()),
                            );
                          },
                        ),
                      ),
                    ],
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
