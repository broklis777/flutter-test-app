import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';
  

  void _onPressed(String value) {
    setState(() {
      if (value == '=') {
        try {
          _result = _calculate(_input);
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'C') {
        _input = '';
        _result = '';
      } else {
        _input += value;
      }
    });
  }

  String _calculate(String input) {
    final expression = input.replaceAll(' ', '');
    final tokens = expression.split(RegExp(r'(\+|\-)'));
    int result = int.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      final operator = tokens[i];
      final operand = int.parse(tokens[i + 1]);
      if (operator == '+') {
        result += operand;
      } else if (operator == '-') {
        result -= operand;
      }
    }

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text(_result, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          _buildKeypad()
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    final buttons = [
      ['7', '8', '9', '+'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', 'C'],
      ['0', '=', '', ''],
    ];

    return Column(
      children: buttons.map((row) {
        return Row(
          children: row.map((text) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: text.isNotEmpty ? () => _onPressed(text) : null,
                  child: Text(text, style: const TextStyle(fontSize: 20)),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}