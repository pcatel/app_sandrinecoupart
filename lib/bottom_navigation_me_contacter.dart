import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'ecrans/contacts.dart';
import 'ecrans/localisation.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final Color backgroundColor;

  const BottomNavigationBarScreen({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  static const List<IconData> _icons = [
    Icons.home,
    Icons.phone,
    Icons.mail,
    Icons.location_on,
    Icons.contact_page,
  ];

  static const List<String> _labels = [
    'Accueil',
    'Appeler',
    'Email',
    'Localisation',
    'Contacter',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        _showConfirmationDialog(
            '0761886820'); // Remplacez le numéro par le numéro que vous souhaitez composer
        break;
      case 2:
        _showEmailDialog();
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Localisation()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Contacts()),
        );
        break;
      default:
        break;
    }
  }

  void _showConfirmationDialog(String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content:
              Text("Vous allez appeler le numéro $phoneNumber. Continuer ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Appeler"),
              onPressed: () {
                Navigator.of(context).pop();
                _launchPhone(phoneNumber);
              },
            ),
          ],
        );
      },
    );
  }

  void _launchPhone(String phoneNumber) async {
    final String uri = 'tel:$phoneNumber';

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Impossible de lancer $phoneNumber';
    }
  }

  void _showEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content:
              Text("Vous allez ouvrir l'application de messagerie. Continuer ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Ouvrir"),
              onPressed: () {
                Navigator.of(context).pop();
                _launchEmail('destinataire@example.com');
              },
            ),
          ],
        );
      },
    );
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'demande de renseignement'},
    );

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Impossible de lancer l\'application de messagerie';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.backgroundColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: _icons.asMap().entries.map((entry) {
          int index = entry.key;
          IconData icon = entry.value;
          String label = _labels[index];
          return BottomNavigationBarItem(
            icon: Icon(
              icon,
              size: 36,
            ),
            label: label,
          );
        }).toList(),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}
