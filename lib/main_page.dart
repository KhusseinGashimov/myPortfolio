import 'package:flutter/material.dart';
import 'package:myportfolio/Calculate.dart';
import 'package:myportfolio/UserLocation.dart';
import 'package:myportfolio/home_page.dart';
import 'package:myportfolio/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePagee()));},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Image.asset('cloudy-day.png',width: 130,)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>Calc()));},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Image.asset('calculator.png',width:130,)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Image.asset('sticky-notes.png',width:130,)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage()));},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  color: Colors.purple,
                  child: Center(child: Image.asset('map.png',width:130,)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
