import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

class Ecran8 extends StatelessWidget {
  const Ecran8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight = 
        MediaQuery.of(context).size.height / numberOfContainers;
    double formContainerHeight = 
        MediaQuery.of(context).size.height - containerHeight;



    double containerWidth = MediaQuery.of(context).size.width;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: containerHeight,
              width: containerWidth,
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
                'Se connecter',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 7, 7)),
              ),
            ),
            Container(
           
             height: formContainerHeight,
             width: containerWidth,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Utilisateur : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDE8C07), // Couleur d'arrière-plan
                          borderRadius:
                              BorderRadius.circular(8.0), // Coins arrondis
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Supprime la bordure
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mot de passe : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFDE8C07), // Couleur d'arrière-plan
                          borderRadius:
                              BorderRadius.circular(8.0), // Coins arrondis
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Supprime la bordure
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                      
                        onPressed: () {
                          // Logique de validation à implémenter ici
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDE8C07), // Change la couleur du bouton
                        ),
                        child: const Text('Valider'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Logique pour gérer le lien "Mot de passe oublié"
                        },
                        child: const Text('Mot de passe oublié'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
    );
  }
}
