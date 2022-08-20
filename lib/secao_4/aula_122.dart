/*
  122. Chart Widgets #02

  
  Aqui nós criamos uma um getter chamado (_recentTransactions)
  que irá usar uma lista para criar uma "sublista", isto porque estamos usando o
  ".where" que irá receber o elemento e tem que retornar "true" or "false"
  sendo que o que estamos usando nele é "é superior a 7 dias"
  
  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  A lógica é: Estamos usando um ".where" que irá sempre tornar um "verdadeiro" ou 
  "false" e então se for verdadeiro entra na lista, se for falso, não, então pegamos
  a data atual (DateTime.now()) e fazemos uma subtração (com duration de 7 dias para trás)
  então podemos verificar se a transação (element) passado é superior a 7 dias ou não
  para entrar na lógica dos últimos 7 dias

  para colocar um texto em cima, o percentual e um texto em baixo, usamos
  Coluna
    -> Text (texto superior)
    -> SizedBox (para separar os elementos)
    -> Container (irá ficar o grafico de porcentagem)
    -> SizedBox (separar os elementos)
    -> Text (texto inferior)

  
  o retorno (como lista) de um objeto que é uma lista e contem diversas informações dentro dela
  child: Row(
    children: groupedTransactions.map((tr) {
      return ChartBar(
        label: tr['day'].toString(),
        value: tr['value'] as double,
        percentage: 0,
      );
    }).toList(),
  
  Stack:
    é um componente que permite colocar um componente em cima do outro, assim como a linha e a coluna
    recebem um conjunto de elementos (uma lista), nós podemos colocar diversos componentes dentro
    dele que ficarão um sobre o outro, neste caso um formato da barra e um outro componente para
    preencher percentualmente quanto a barra esta ocupada

*/

import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transacton_form.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 'T0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 'T1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 'T20',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Chart(_recentTransactions), TransactionList(_transactions)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
