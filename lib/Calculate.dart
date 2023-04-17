import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:myportfolio/buttons.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C','Del','%','/',
    '7','8','9','x',
    '4','5','6','-',
    '1','2','3','+',
    '0','.','ANS','=',
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 50,left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(userQuestion, style: TextStyle(fontSize: 20),)),
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: Text(userAnswer,style: TextStyle(fontSize: 20),))
                  ],
                ),
              )),
          Expanded(
              flex:2,
              child: Center(
                  child: Container(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index){

                          if(index==0) {
                            return MyButton(
                              buttomTapped: (){
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.green,
                              textColor: Colors.white,
                            );
                          }

                          else if(index==1) {
                            return MyButton(
                              buttomTapped: (){
                                setState(() {
                                  userQuestion = userQuestion.substring(0, userQuestion.length-1);
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                          else if(index==buttons.length-1) {
                            return MyButton(
                              buttomTapped: (){
                                setState(() {
                                  equalPressed();
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                            );
                          }
                          else{
                            return MyButton(
                              buttomTapped: (){
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])?Colors.deepPurple:Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])?Colors.white:Colors.deepPurple,
                            );
                          }
                        }
                    ),
                  ))
          )],
      ),
    );
  }

  bool isOperator(String x){
    if(x=='%' || x=='/' || x=='x' || x=='-' || x== '+' || x=='='){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}