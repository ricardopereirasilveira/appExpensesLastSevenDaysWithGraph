/*
  112. Fechando o Formulário (Modal)

  Uma das coisas quando estamos escrevendo um código e queremos escrever algo novo
  é saber onde escrever isto

  Navigator é um widget do tipo Stateful e tem um método estatico chamado
  "of" (Navigator.of())

  o .of é um componente muito padrão quando temos um widget herdado, que tem a 
  capacidade de um widget que esta no topo da árvore de componentes, passar
  uma informação para a parte abaixo da árvore de componente. Se fizermos
  isto através do State nós teriamos que passar a informação de componente
  por componente e então o último recebe, com o componente herdado nós
  conseguimos usar o método "of" passando o context

  o Of é um método static, isto significa que não precisamos criar uma
  instancia do objeto para poder usar ele.

  Nós chamamos o Navigator.of(context).pop().
  Imagina que temos uma pilha de telas e queremos sacar a primeira (fechar
  a primeira) nós chamamos o .pop() e tiramos o primeiro elemento da
  pilha, ou seja, a mesma coisa em cima do Navigator

  Ou seja, nós estamos abrindo o modal através do método
    _openTransactionFormModal
  e fechando o modal através do Navigator
    Navigator.of(context).pop();

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
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 'T1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T20',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
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
        title: const Text("Despesas Pessoais"),
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
