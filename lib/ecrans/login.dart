import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';
  bool showPassword = false; // Variable pour afficher/masquer le mot de passe

  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Les deux champs doivent être renseignés.';
      });
      return;
    }

    final response = await http.post(
      Uri.parse(
          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/php/connect.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        String nom = data['user']['nom'];
        String prenom = data['user']['prenom'];
        setState(() {
          message = 'Bonjour $prenom $nom, vous êtes bien connecté.';
        });
      } else {
        setState(() {
          message = 'Email ou mot de passe erroné.';
        });
      }
    } else {
      setState(() {
        message = 'Erreur de connexion au serveur.';
      });
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
            color: Color.fromARGB(255, 1, 1, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200, // Ajustez la hauteur selon vos besoins
              width: MediaQuery.of(context).size.width,
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
                  color: Color.fromARGB(255, 7, 7, 7),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                      color: const Color(0xFFDE8C07),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
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
                      color: const Color(0xFFDE8C07),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !showPassword, // Utilisation de la variable showPassword pour afficher/masquer le mot de passe
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDE8C07),
                    ),
                    child: const Text('Valider'),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
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
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFDE8C07)),
    );
  }
}
