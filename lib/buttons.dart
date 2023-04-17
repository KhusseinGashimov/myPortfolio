import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttomTapped;
  const MyButton({Key? key, this.color,this.textColor,required this.buttonText,this.buttomTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: buttomTapped,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,style: TextStyle(color: textColor,fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
