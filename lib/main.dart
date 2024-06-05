import 'package:flutter/material.dart';
import 'calculadora.dart';
import 'historico.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CalculadoraScreen(),
        '/historico': (context) => HistoricoScreen(),
      },
    );
  }
}
