
import 'package:flutter/material.dart';
import 'home_screen.dart';


import 'ecrans/consultations_deroulement.dart';
import 'ecrans/consultations_teleconsultations.dart';
import 'ecrans/consultations_relations_mutuelle.dart';
import 'ecrans/consultations_consultations.dart';
import 'ecrans/contacts.dart';



class BottomNavigationBarScreen extends StatefulWidget {
 final Color backgroundColor; // Nouveau paramètre

  const BottomNavigationBarScreen({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);


  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  static const List<IconData> _icons = [
    Icons.home,
    Icons.airline_seat_recline_normal,
    Icons.api_sharp,
    Icons.assignment_ind,
    Icons.bakery_dining_sharp,
    Icons.contact_page
  ];

  static const List<String> _labels = [
    'Accueil',
    'consultations',
    'Déroulement',
    'Téléconsultations',
    'Relations Mutuelles',
    'Me contacter',
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
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsultationsConsultations()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsultationsDeroulement()),
        );
        break;
      case 3:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsultationsTeleconsultation()),
        );
        break;
      case 4:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsultationsMutuelle()),
        );// Naviguer vers l'écran correspondant
        break;
      case 5:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Contacts()),
        );// Naviguer vers l'écran correspondant
        break;// Naviguer vers l'écran correspondant
       
      default:
        break;
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
