import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  void buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (text == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '') {
          equation = '0';
        }
      } else if (text == '=') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('−', '-');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = text;
        } else {
          equation = equation + text;
        }
      }
    });
  }

  Widget BuildTextedButton(
    String buttonText,
    Color buttonColor,
    double buttonHeight,
  ) {
    return Container(
      color: buttonColor,
      height: MediaQuery.of(context).size.height * buttonHeight * .1,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
                color: Colors.white, width: 0.2, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              )),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildTextedButton('C', Colors.amber, 1),
                        BuildTextedButton('⌫', Colors.red, 1),
                        BuildTextedButton('+', Colors.blue, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildTextedButton('7', Colors.black54, 1),
                        BuildTextedButton('8', Colors.black54, 1),
                        BuildTextedButton('9', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildTextedButton('4', Colors.black54, 1),
                        BuildTextedButton('5', Colors.black54, 1),
                        BuildTextedButton('6', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildTextedButton('1', Colors.black54, 1),
                        BuildTextedButton('2', Colors.black54, 1),
                        BuildTextedButton('3', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildTextedButton('.', Colors.black54, 1),
                        BuildTextedButton('0', Colors.black54, 1),
                        BuildTextedButton('00', Colors.black54, 1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          BuildTextedButton('×', Colors.blue, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          BuildTextedButton('−', Colors.blue, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          BuildTextedButton('÷', Colors.blue, 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          BuildTextedButton('=', Colors.red, 2),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
