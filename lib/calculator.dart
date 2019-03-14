import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1;
  double num2;
  String operand;
  bool midCalculation = false;
  String selectedOperand;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new ButtonTheme(
        height: 90.0,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              child: new Text(
                output,
                style: Theme.of(context).textTheme.display3,
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.centerRight,
            ),
            new Expanded(child: Divider()),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumberButton("AC", 1, 10.0, 5.0, 5.0, 5.0),
                buildNumberButton("+/-", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("%", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("÷", 1, 5.0, 5.0, 5.0, 10.0),
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumberButton("7", 1, 10.0, 5.0, 5.0, 5.0),
                buildNumberButton("8", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("9", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("x", 1, 5.0, 5.0, 5.0, 10.0),
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumberButton("4", 1, 10.0, 5.0, 5.0, 5.0),
                buildNumberButton("5", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("6", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("-", 1, 5.0, 5.0, 5.0, 10.0),
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumberButton("1", 1, 10.0, 5.0, 5.0, 5.0),
                buildNumberButton("2", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("3", 1, 5.0, 5.0, 5.0, 5.0),
                buildNumberButton("+", 1, 5.0, 5.0, 5.0, 10.0),
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumberButton("0", 2, 10.0, 5.0, 10.0, 5.0),
                buildNumberButton(",", 1, 5.0, 5.0, 10.0, 5.0),
                buildNumberButton("=", 1, 5.0, 5.0, 10.0, 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildNumberButton(
      String buttonText,
      int expansion,
      double paddingLeft,
      double paddingTop,
      double paddingBottom,
      double paddingRight) {
    return new Expanded(
      child: new Padding(
        child: new RaisedButton(
            child: new Text(
              buttonText,
              style: Theme.of(context).textTheme.body1,
            ),
            onPressed: () => buttonPressed(buttonText),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: (selectedOperand == buttonText)
                ? Theme.of(context).highlightColor
                : Theme.of(context).primaryColor),
        padding: EdgeInsets.fromLTRB(
            paddingLeft, paddingTop, paddingRight, paddingBottom),
      ),
      flex: expansion,
    );
  }

  buttonPressed(String buttonText) {
    switch (buttonText) {
      case "AC":
        {
          _output = "0";
          num1 = null;
          num2 = null;
          operand = null;
          midCalculation = false;
        }
        break;
      case "÷":
      case "x":
      case "-":
      case "+":
        {
          if (!midCalculation) {
            if (operand == null)
              saveOperandAndNumber(buttonText);
            else {
              executeMathOperation();
              midCalculation = true;
              saveOperandAndNumber(buttonText);
            }
          } else
            operand = buttonText;
        }
        break;

      case "=":
        {
          executeMathOperation();
          midCalculation = false;
        }
        break;

      case (","):
        {
          if (output.contains(","))
            print("Already decimal");
          else
            _output = removeDecimals(_output) + ",";
        }
        break;
      case "+/-":
        {
          _output = (double.parse(_output) * -1).toString();
        }
        break;
      case "%":
        {
          _output = (double.parse(_output) / 100).toString();
        }
        break;
      default:
        {
          if (_output == "0" || midCalculation) {
            midCalculation = false;
            _output = buttonText;
          } else {
            _output = removeDecimals(_output) + buttonText;
          }
        }
        break;
    }

    debugPrint(_output);

    setState(() {
      if (!_output.contains(",") && double.parse(_output) % 1 == 0)
        output = removeDecimals(_output);
      else
        output = _output.replaceAll(".", ",");
      selectedOperand = operand;
    });
  }

  String removeDecimals(String numberString) {
    if (!numberString.contains(",") && double.parse(numberString) % 1 == 0){
      String noDecimals = double.parse(numberString).toInt().toString();
      return noDecimals;
    }
    return numberString;
  }

  void executeMathOperation() {
    num2 = double.parse(_output);
    switch (operand) {
      case "÷":
        _output = (num1 / num2).toString();
        break;
      case "x":
        _output = (num1 * num2).toString();
        break;
      case "-":
        _output = (num1 - num2).toString();
        break;
      case "+":
        _output = (num1 + num2).toString();
        break;
      default:
        break;
    }
    num1 = 0.0;
    num2 = 0.0;
    operand = null;
  }

  void saveOperandAndNumber(String buttonText) {
    num1 = double.parse(_output.replaceAll(",", "."));
    if (!midCalculation) _output = "0";
    operand = buttonText;
  }
}
