import 'package:flutter/material.dart';

class MainPageFeed extends StatefulWidget {
  const MainPageFeed({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPageFeed> createState() => _MainPageFeedState();
}

class _MainPageFeedState extends State<MainPageFeed> {
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
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      _choseColor(Colors.blue);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Container(
                      child: const Text('blue'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      _choseColor(Colors.red);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Container(
                      child: const Text('red'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      _choseColor(Colors.green);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Container(
                      child: const Text('green'),
                    ),
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
