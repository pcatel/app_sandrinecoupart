import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../bottom_navigation.dart';
import '../home_screen.dart';
import 'localisation.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _demandeController = TextEditingController();
  String _selectedService = 'Consultation';

  @override
  void dispose() {
    _emailController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _demandeController.dispose();
    super.dispose();
  }

  void _showEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('E-mail envoyé avec succès'),
          content: const Text('Votre e-mail a été envoyé avec succès.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Récapitulatif'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom: ${_nomController.text}'),
              Text('Prénom: ${_prenomController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Service: $_selectedService'),
              Text('Demande: ${_demandeController.text}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Modifier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sendEmail();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
              ),
              child: const Text('Envoyer'),
            ),
          ],
        );
      },
    );
  }

  void _sendEmail() async {
    final smtpServer = gmail('pascalcatel@gmail.com', 'yybn hbfr alxl shii');
    final message = Message()
      ..from = Address(_emailController.text)
      ..recipients.add('pcatel@pascalcatel.com')
      ..subject = 'Demande de renseignement'
      ..text =
          'Vous avez un message de : ${_nomController.text} ${_prenomController.text}\n'
              'Pour une demande concernant : $_selectedService\n'
              '${_demandeController.text}\n\n'
              'Email : ${_emailController.text}\n\n'
              'Bonne journée.';

    try {
      await send(message, smtpServer);
      _showEmailSentDialog();
    } catch (error) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'envoi de l\'e-mail'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        title: const Text(
          'Sandrine Coupart : Diététicienne - Nutritionniste',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: containerHeight * 0.08,
              width: containerWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/contact.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0xFFE91E63),
                    BlendMode.color,
                  ),
                ),
              ),
              child: const Text(
                'Contacts',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 7, 7)),
              ),
            ),
            // Container 1
            Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Container(
                  color: const Color.fromARGB(255, 255, 244, 247),
                  height: containerHeight * 0.08,
                  width: containerWidth,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Aligne les éléments à gauche
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Centre les éléments verticalement
                    children: [
                      // Partie 1 de la première row
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/phone.png'),
                      ),
                      // Partie 2 de la première row
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Centre les éléments horizontalement dans la colonne
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Centre les éléments verticalement dans la colonne
                              children: [
                                Text(
                                  'Téléphone',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 7, 7, 7)),
                                ),
                                Text(
                                  '+33123456789',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 7, 7, 7)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                height: containerHeight * 0.08,
                width: containerWidth,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Aligne les éléments à gauche
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centre les éléments verticalement
                  children: [
                    // Partie 1 de la première row
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/email.png'),
                    ),
                    // Partie 2 de la première row
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centre les éléments horizontalement dans la colonne
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Centre les éléments verticalement dans la colonne
                            children: [
                              Text(
                                'Formulaire de contact',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                'Merci de remplir tous les champs du formulaire, je vous répondrai dans les plus brefs délais',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            // Container 2 avec le formulaire
            Container(
              color: const Color.fromARGB(255, 255, 244, 247),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomController,
                      decoration: const InputDecoration(labelText: 'Nom'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _prenomController,
                      decoration: const InputDecoration(labelText: 'Prénom'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Veuillez entrer votre prénom';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value?.isEmpty ?? true || !value!.contains('@')) {
                          return 'Veuillez entrer une adresse e-mail valide';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value!;
                        });
                      },
                      items: [
                        'Consultation',
                        'Ateliers prévention',
                        'Infos nutrition',
                        'Autre demande'
                      ]
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                          labelText: 'Choisir un service'),
                    ),
                    TextFormField(
                      controller: _demandeController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          labelText: 'Préciser votre demande'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Veuillez préciser votre demande';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showSummaryDialog();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E63),
                      ),
                      child: const Text('Envoyer le message'),
                    ),
                  ],
                ),
              ),
            ),

            // Container 3
            Container(
                height: containerHeight * 0.15,
                width: containerWidth,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Aligne les éléments à gauche
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centre les éléments verticalement
                  children: [
                    // Partie 1 de la première row
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                          'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/horaires.png'),
                    ),
                    // Partie 2 de la première row
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centre les éléments horizontalement dans la colonne
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Centre les éléments verticalement dans la colonne
                            children: [
                              Text(
                                'Horaires',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                'Lundi - Vendredi',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                '09:00 - 12:00 14:00 - 18:00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                'Samedi',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                '09:00 - 12:00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            // Container 3
            Container(
                color: const Color.fromARGB(255, 255, 244, 247),
                height: containerHeight * 0.1,
                width: containerWidth,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Aligne les éléments à gauche
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Centre les éléments verticalement
                  children: [
                    // Partie 1 de la première row
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Localisation()), // Remplacez 'ecran7()' par le nom de votre écran.
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                            'https://pascalcatel.com/maquettes/sandrineCoupart/appmobile/localisation.png'),
                      ),
                    ),
                    // Partie 2 de la première row
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centre les éléments horizontalement dans la colonne
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Centre les éléments verticalement dans la colonne
                            children: [
                              Text(
                                'Se rendre au cabinet',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                '97 rue des bouvreuils',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                '45770 SARAN',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                              Text(
                                'Parking privé',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 7, 7, 7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFE91E63)),
    );
  }
}
