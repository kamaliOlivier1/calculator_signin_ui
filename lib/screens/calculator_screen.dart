import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentNumber = "";
  String _operand = "";
  double _result = 0.0;
  bool _isFirstOperand = true;

  void _updateOutput(String value) {
    setState(() {
      if (_output == "0" || _output == "Error") {
        _output = value;
      } else {
        _output += value;
      }
      _currentNumber = _output;
    });
  }

  void _clear() {
    setState(() {
      _output = "0";
      _currentNumber = "";
      _operand = "";
      _result = 0.0;
      _isFirstOperand = true;
    });
  }

  void _performOperation(String operand) {
    setState(() {
      if (!_isFirstOperand) {
        _calculate();
      } else {
        _result = double.parse(_currentNumber);
        _isFirstOperand = false;
      }
      _operand = operand;
      _output = "0";
      _currentNumber = "";
    });
  }

  void _calculate() {
    double current = double.parse(_currentNumber);
    switch (_operand) {
      case "+":
        _result += current;
        break;
      case "-":
        _result -= current;
        break;
      case "*":
        _result *= current;
        break;
      case "/":
        if (current == 0) {
          _output = "Error";
          _operand = "";
          return;
        }
        _result /= current;
        break;
      default:
        return;
    }
    setState(() {
      _output = _result.toString();
      _currentNumber = _result.toString();
      _operand = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48.0),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
        ),
        onPressed: () {
          if (text == "C") {
            _clear();
          } else if (text == "=") {
            _calculate();
          } else if (text == "+" || text == "-" || text == "*" || text == "/") {
            _performOperation(text);
          } else {
            _updateOutput(text);
          }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
