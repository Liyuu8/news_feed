import 'package:flutter/material.dart';

class AboutAsPage extends StatefulWidget {
  @override
  _AboutAsPageState createState() => _AboutAsPageState();
}

class _AboutAsPageState extends State<AboutAsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // TODO:
        body: Container(
          child: Center(
            child: Text('AboutUsPage'),
          ),
        ),
      ),
    );
  }
}
