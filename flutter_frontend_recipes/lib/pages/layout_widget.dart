import 'package:flutter/material.dart';
import 'package:flutter_frontend_recipes/pages/my_home_page.dart';
import 'package:flutter_frontend_recipes/constants/icon_designs.dart';
import 'package:flutter_frontend_recipes/constants/color_designs.dart';
import 'package:flutter_frontend_recipes/constants/font_styles.dart';


class LayoutWidget extends StatefulWidget {
  const LayoutWidget({Key? key}) : super(key: key);

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}


class _LayoutWidgetState extends State<LayoutWidget> {
  int _currentIndex = 0;



  // TODO: Die Liste von MyHomePage zu den tatsächlichen Seiten ändern

  final List<Widget> _pages = <Widget>[
    const MyHomePage(title: 'MVP Recipe App - Startpage'),
    const MyHomePage(title: 'MVP Recipe App - second page'),
    const MyHomePage(title: 'MVP Recipe App - third page'),
    const MyHomePage(title: 'MVP Recipe App - fourth page')
  ];

  IconDesigns iconDesigns = IconDesigns();
  ColorDesign colorDesign = ColorDesign();
  FontStyles fontStyles = FontStyles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(iconDesigns.homePageIcon),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(iconDesigns.recipePageIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(iconDesigns.shoppingListPageIcon),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(iconDesigns.profilePageIcon),
            label: 'Messages',
          ),
        ],

        currentIndex: _currentIndex,
        selectedItemColor: colorDesign.selectedIconColor,
        unselectedItemColor: colorDesign.unSelectedIconColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}



