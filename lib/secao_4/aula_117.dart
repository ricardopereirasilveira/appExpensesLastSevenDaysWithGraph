/*
  117. Adicionando Imagem

  Quando nossa aplicação não tiver nenhuma transaction ela irá apresentar ao invés
  da lista vazia, uma imagem
  
  Para começar temos que registrar a imagem em pubspec.yaml para termos acesso a ela
  ela foi colocada dentro de assets -> images -> waiting.png

  É necessario reiniciar a aplicação ao adicionar as fontes

  No nosso caso, o ListView é que tem que ser modificado, caso não exista nenhuma transação
  então antes do ListView (no child), vamos colocar uma operação ternaria nele para
  caso esteja vazia o Transaction, mostrar a imagem

  transactions.isEmpty ? Column() : ListView.builder()
  se a lista que esta guardada em transactions estiver vazia (returnando true), então
  ele irá mostrar o Column, caso contrário (retornando false) ele irá mostrar o 
  ListView.builder()

  Para inserir a imagem, nós usamos o asset da classe Image, ficando
    child: Image.asset(
      "assets/images/waiting.png",
    ),
  
  E enviamos a imagem através do caminho relativo.

  Eventualmente, as coisas podem ficar "grudadas" e nós temos uma propriedade chamada
  SizedBox que recebe um parametro nomeado chamado "height" (altura) que pode dar um
  respiro entre dois elementos que eventualmente estão grudados na vertical

    SizedBox(height: 20)
  

  
  

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
