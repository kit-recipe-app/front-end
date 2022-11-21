import 'package:flutter/material.dart';

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
    const MyHomePage(title: 'MVP Recipe App - Startpage'),
    const MyHomePage(title: 'MVP Recipe App - second page'),
    const MyHomePage(title: 'MVP Recipe App - third page'),
    const MyHomePage(title: 'MVP Recipe App - fourth page')
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
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _chosenColor = Colors.black12;

  void _choseColor(Color color) {
    setState(() {
      _chosenColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Color chosen:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'chosen Color',
              style: TextStyle(
                  color: _chosenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _choseColor(Colors.blue);
                  },
                  child: Container(
                    color: Colors.blue,
                    child: const Text('blue'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _choseColor(Colors.red);
                  },
                  child: Container(
                    color: Colors.red,
                    child: const Text('red'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _choseColor(Colors.green);
                  },
                  child: Container(
                    color: Colors.green,
                    child: const Text('green'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
