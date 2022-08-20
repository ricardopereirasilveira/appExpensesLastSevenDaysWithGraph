/*
  120. Chart Widgets #01

  Iremos criar um novo componente (em sua devida pasta (componentes)) chamado "chart.dart"

  Nele nós criamos um Stateless que irá passar um Card e nesse card iremos colocar uma Row
  dentro (que irá representar a linha que dentro tera os dias individuais)

  Nós iremos passar para o gráfico apenas as transações mais recentes (última semana)

  A lógica é: 
  final weekDay = DateTime.now().subtract(Duration(days: index));
  Pega a data de hoje(DateTime.now) e faz um subtract passando um durante de dia que foi pego
  no INDEX (que irá retornar o tamanho, que é 7, retornando um de cada vez)

  DateFormat.E().format(weekDay)[0];
  Aqui irá formatar a Data com .E() e faz um format atraves do weekday (que retorna o dia da
  semana) pegando a primeira letra [0]

  bool sameDay = recentTransaction[i].date.day == weekDay.day;
  bool sameMonth = recentTransaction[i].date.month == weekDay.month;
  bool sameYear = recentTransaction[i].date.year == weekDay.year;

  verifica se no for, o recenteTransaction.date (day, month ou year) corresponde ao mesmo da
  variavel weekDay, para estarmos falando da mesma data (não de datas anteriores a 7 dias)

  o código ficara assim inicialmente com a lógica de programação

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      print("${DateFormat.E().format(weekDay)[0]} ${totalSum}");

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });


*/

import 'dart:math';

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
    // Transaction(
    //   id: 'T1',
    //   title: 'Novo Tênis de Corrida',
    //   value: 310.76,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T20',
    //   title: 'Conta de Luz',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
  ];

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
        children: [
          Container(
            child: const Card(
              color: Colors.blue,
              child: Text("Gráfico"),
              elevation: 5,
            ),
          ),
          // TransactionUser(),
          TransactionList(_transactions)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
