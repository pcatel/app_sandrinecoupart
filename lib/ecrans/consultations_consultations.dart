import 'package:flutter/material.dart';
import '../bottom_navigation.dart';

class Ecran9 extends StatefulWidget {
  const Ecran9({Key? key}) : super(key: key);

  @override
  _Ecran9State createState() => _Ecran9State();
}

class _Ecran9State extends State<Ecran9> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Color> tabColors = [
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
    const Color(0xFFF0D2A3),
    const Color(0xFFDE8C07),
    const Color(0xFFF0D2A3),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int numberOfContainers = 6;
    double containerHeight =
        MediaQuery.of(context).size.height / numberOfContainers;
    double containerWidth = MediaQuery.of(context).size.width;

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
      body: Column(
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
              'Les consultations',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 249, 223, 181),
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                color: Color(0xFFDE8C07),
              ),
              labelColor: Colors.black, // Couleur du texte des onglets actifs
              tabs: List.generate(
                7,
                (index) => Tab(
                  text: '${index + 1}',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  7,
                  (index) => Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: tabColors[index],
                      child: Text(
                        'Contenu de l\'onglet ${index + 1}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(
        backgroundColor: Color(0xFFDE8C07),
      ),
    );
  }
}
