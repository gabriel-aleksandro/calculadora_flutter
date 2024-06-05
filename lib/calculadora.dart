import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _output = "0";
  String _result = "0";
  List<String> _historico = [];

  void _botaoPressionado(String botaoTexto) {
    setState(() {
      if (botaoTexto == "C") {
        _output = "0";
        _result = "0";
      } else if (botaoTexto == "=") {
        try {
          _result = _calcular(_output);
          _historico.add(_output + " = " + _result);
          _output = _result;
        } catch (e) {
          _result = "Erro";
        }
      } else {
        if (_output == "0") {
          _output = botaoTexto;
        } else {
          _output += botaoTexto;
        }
      }
    });
  }

  String _calcular(String entrada) {
    try {
      final expression = Expression.parse(entrada);
      final evaluator = const ExpressionEvaluator();
      var context = <String, dynamic>{};
      final result = evaluator.eval(expression, context);
      return result.toString();
    } catch (e) {
      return "Erro";
    }
  }

  Widget _construirBotao(String botaoTexto) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _botaoPressionado(botaoTexto),
        child: Text(botaoTexto, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/historico', arguments: _historico);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(_output, style: TextStyle(fontSize: 48)),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(children: [_construirBotao("7"), _construirBotao("8"), _construirBotao("9"), _construirBotao("/")]),
              Row(children: [_construirBotao("4"), _construirBotao("5"), _construirBotao("6"), _construirBotao("*")]),
              Row(children: [_construirBotao("1"), _construirBotao("2"), _construirBotao("3"), _construirBotao("-")]),
              Row(children: [_construirBotao("."), _construirBotao("0"), _construirBotao("00"), _construirBotao("+")]),
              Row(children: [_construirBotao("C"), _construirBotao("=")]),
            ],
          )
        ],
      ),
    );
  }
}
