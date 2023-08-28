import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'ecrans/login.dart';

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
    Icons.book,
    Icons.category,
    Icons.person,
    Icons.location_on,
    Icons.search,
  ];

  static const List<String> _labels = [
    'Accueil',
    'A définir',
    'A définir',
    'login',
    'A définir',
    'A définir',
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
        // Naviguer vers l'écran correspondant
        break;
      case 2:
        // Naviguer vers l'écran correspondant
        break;
      case 3:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Ecran8()),
        );
        break;
      case 4:
        // Naviguer vers l'écran correspondant
        break;
      case 5:
        // Naviguer vers l'écran correspondant
        break;
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
