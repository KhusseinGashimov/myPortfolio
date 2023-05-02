import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class RuEn extends StatefulWidget {
  @override
  _RuEnState createState() => _RuEnState();
}

class _RuEnState extends State<RuEn> {
  final translator = GoogleTranslator();
  String _inputText = '';
  String _outputText = '';

  void _translateText() async {
    final translation = await translator.translate(_inputText, from: 'ru', to: 'en');
    setState(() {
      _outputText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text('Russian to English'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter text to translate',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _inputText = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _translateText,
            child: Text('Translate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple, // set the background color of the button
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              _outputText,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
