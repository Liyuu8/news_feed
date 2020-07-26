import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AboutAsPage extends StatefulWidget {
  @override
  _AboutAsPageState createState() => _AboutAsPageState();
}

class _AboutAsPageState extends State<AboutAsPage> {
  final String animatedText = 'News Feed App';
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedContainer(
            width: _selected ? 300.0 : 50.0,
            height: _selected ? 200.0 : 25.0,
            alignment: _selected ? Alignment.center : Alignment.topCenter,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            child: AutoSizeText(
              animatedText,
              style: TextStyle(fontSize: 40.0),
              minFontSize: 6.0,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          tooltip: 'start animation',
          onPressed: () {
            setState(() {
              _selected = !_selected;
            });
          },
        ),
      ),
    );
  }
}
