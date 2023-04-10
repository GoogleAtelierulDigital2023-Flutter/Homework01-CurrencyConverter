import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Currency convertor'),
          ),
          body: const CurrencyConvertor(),
        ),
      ),
    );
  }
}

class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({super.key});

  @override
  State<CurrencyConvertor> createState() => CurrencyConvertorState();
}

class CurrencyConvertorState extends State<CurrencyConvertor> {
  final TextEditingController _textController = TextEditingController();

  static const double _exchangeRate = 4.9;

  bool _isError = false;
  double _exchangeResult = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/bani.jpg'),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12.0),
              errorText: _isError ? 'Please enter a valid amount' : null,
              labelText: 'Enter the amount in EUR',
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.')),
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) {
              setState(
                () {
                  _isError = false;
                },
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final double? inputNumber = double.tryParse(_textController.text);

              setState(() {
                if (inputNumber == null || inputNumber == 0) {
                  _isError = true;
                } else {
                  _exchangeResult = inputNumber * _exchangeRate;
                }
              });
            },
            child: const Text('CONVERT'),
          ),
          Text(
            _exchangeResult == 0 ? '' : '${_exchangeResult.toStringAsFixed(2)} RON',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
