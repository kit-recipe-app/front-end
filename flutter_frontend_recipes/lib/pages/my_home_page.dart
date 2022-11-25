import 'package:flutter/material.dart';


// TODO: Diese Klasse dient in erster Linie zu demonstartionszwecken und muss später umgeschrieben
// TODO: oder eventuell entfernt werden

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


