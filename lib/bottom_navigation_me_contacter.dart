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

  // Ajoutez une variable pour stocker le BuildContext
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    // Obtenez le BuildContext dans initState
    _context = context;
  }

  void _launchPhone(String phoneNumber) async {
    Uri phoneno = Uri.parse('tel:0761886820');
    if (await launchUrl(phoneno)) {
      //dialer opened
    } else {
      //dailer is not opened
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          _context, // Utilisez le BuildContext stocké
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        _launchPhone('+97798345348734');

      case 2:
        _showEmailDialog();
        break;
      case 3:
        Navigator.push(
          _context, // Utilisez le BuildContext stocké
          MaterialPageRoute(builder: (context) => const Localisation()),
        );
        break;
      case 4:
        Navigator.push(
          _context, // Utilisez le BuildContext stocké
          MaterialPageRoute(builder: (context) => const Contacts()),
        );
        break;
      default:
        break;
    }
  }

  void _showEmailDialog() {
    showDialog(
      context: _context, // Utilisez le BuildContext stocké
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              "Vous allez ouvrir l'application de messagerie. Continuer ?"),
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

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
