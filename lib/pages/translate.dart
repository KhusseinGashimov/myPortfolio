import 'package:flutter/material.dart';
import 'package:myportfolio/pages/EnRu.dart';
import 'package:myportfolio/pages/RuEn.dart';

class Translate extends StatelessWidget {
  const Translate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RuEn()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Text("Ru-En",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnRu()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Text("En-Ru",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
