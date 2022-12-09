import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/feed/main-page-feed.dart';
import 'package:flutter_frontend_recipes/pages/profile/main-page-profile.dart';
import 'package:flutter_frontend_recipes/pages/shopping-lists/main-page-shopping-lists.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recipe App',
      home: LayoutWidget(),
    );
  }
}

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({Key? key}) : super(key: key);

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {



  int _currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    const MainPageFeed(title: 'MVP Recipe App - Startpage'),
    const MyWidgettt(title: 'hello'),
    MainPageShoppingLists(),
    Container(
      color: Colors.amber,
      child: const Text('Profil'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Shopping Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
