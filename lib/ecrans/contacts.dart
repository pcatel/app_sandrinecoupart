import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart'; // Utilisez un serveur SMTP approprié
import '../home_screen.dart';

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
      _showEmailSentDialog(); // Afficher le dialogue de succès!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    } catch (error) {
      //print('Erreur lors de l\'envoi de l\'e-mail: $error');
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'envoi de l\'e-mail'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
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
              decoration:
                  const InputDecoration(labelText: 'Choisir un service'),
            ),
            TextFormField(
              controller: _demandeController,
              maxLines: 4,
              decoration:
                  const InputDecoration(labelText: 'Préciser votre demande'),
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
                  _showSummaryDialog(); // Afficher le récapitulatif
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
              ),
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFE91E63)),
    );
  }
}
