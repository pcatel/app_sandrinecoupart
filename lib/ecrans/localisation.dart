import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../bottom_navigation.dart';

class Localisation extends StatelessWidget {
  const Localisation({Key? key}) : super(key: key);

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
      body: Column(
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
          Expanded(
            child: WebView(
              initialUrl: 'https://goo.gl/maps/Eks4KR67PkjwQ2d48',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          const BottomNavigationBarScreen(backgroundColor: Color(0xFFE91E63)),
    );
  }
}
