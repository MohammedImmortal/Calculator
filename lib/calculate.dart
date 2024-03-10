import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _result = '0';
  String _display = '0';
  String _operand = '';
  String _memory = '';

  int countDecimalPlaces(String numStr) {
    int decimalIndex = numStr.indexOf('.');
    if (decimalIndex == -1) {
      return 0;
    }
    return numStr.length - decimalIndex - 1;
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: (buttonText == '+' ||
                  buttonText == '-' ||
                  buttonText == 'X' ||
                  buttonText == '/' ||
                  buttonText == '=')
              ? Colors.teal
              : Color.fromARGB(255, 25, 16, 49),
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: TextButton(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    if (buttonText == 'CLEAR') {
      _num1 = 0.0;
      _num2 = 0.0;
      _result = '0';
      _display = '0';
      _operand = '';
    } else if (buttonText == 'MR') {
      _display = _memory;
    } else if (buttonText == 'MC') {
      _memory = '';
    } else if (buttonText == 'M+') {
      _memory = _display;
    } else if (buttonText == 'M-') {
      double num = double.parse(_display);
      double invertedNum = -1 * num;
      String numStr = invertedNum.toString();
      _memory = numStr;
    } else if (buttonText == '%') {
      _num1 = double.parse(_display);
      _display = (_num1 / 100).toString();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'X' ||
        buttonText == '/') {
      _num1 = double.parse(_display);
      _display = buttonText;
      _operand = buttonText;
    } else if (buttonText == '.') {
      if (_display.contains('.')) {
        return;
      } else {
        _display = _display + buttonText;
      }
    } else if (buttonText == '=') {
      _num2 = double.parse(_display);
      if (_operand == '+') {
        _display = (_num1 + _num2).toString();
      }
      if (_operand == '-') {
        _display = (_num1 - _num2).toString();
      }
      if (_operand == 'X') {
        _display = (_num1 * _num2).toString();
      }
      if (_operand == '/') {
        _display = (_num1 / _num2).toString();
      }

      _num1 = 0.0;
      _num2 = 0.0;
      _operand = '';
      if (countDecimalPlaces(_display) <= 2) {
        _display = _display;
      } else {
        _display = double.parse(_display).toStringAsFixed(2);
      }
    } else {
      if (_display == '0' ||
          _display == '+' ||
          _display == '-' ||
          _display == 'X' ||
          _display == '/') {
        _display = buttonText;
      } else {
        _display = _display + buttonText;
      }
    }

    setState(() => _result = _display);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: Colors.black,
              child: Row(
                children: [
                  Text(
                    'M',
                    style: TextStyle(
                      color: _memory == '' ? Colors.black : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 15.0),
                child: Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 450,
              color: Color.fromARGB(255, 25, 16, 49),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(children: [
                      Row(children: [
                        buildButton('MC'),
                        buildButton('M+'),
                        buildButton('M-'),
                        buildButton('MR')
                      ]),
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('/')
                    ]),
                    Row(children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('X')
                    ]),
                    Row(children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('-')
                    ]),
                    Row(children: [
                      buildButton('.'),
                      buildButton('0'),
                      buildButton('%'),
                      buildButton('+')
                    ]),
                    Row(children: [
                      buildButton('CLEAR'),
                      buildButton('='),
                    ])
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
