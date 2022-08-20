/*
  134. Excluindo Transação

  Agora iremos implementar como excluir uma transação cadastrada

  Dentro do ListTile temos uma propriedade (parametro nomeado) que irá inserir algo
  do lado direito do Card

  trailing: IconButton(
    onPressed: () {},
    icon: Icon(Icons.delete),
    color: Theme.of(context).errorColor,
  ),

  Neste caso colocamos um botão com um Icone de delete

  Criamos uma nova função chamada "_removeTransaction" que recebe um ID no parametro (string)
  então nós damos um "removeWhere" na lista "_transactions" onde retorna true/false
  para que, se o ID for igual ao transaction.id ele irá deletar

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere(
        (element) {
          return element.id == id;
        },
      );
    });
  }

  So que iremos fazer o filho conversar com o pai, para fazer isto no 'main.dart' iremos inserir
  o _removeTransaction que recebe um ID, então enviaremos essa função para o TransactionList
  através do construtor da Classe

  TransactionList(_transactions, _removeTransaction)

  ---> transaction_list.dart
  Neste, iremos criar uma variavel que recebe como parametro uma função que esta função irá receber
  uma String (neste caso, vai ser o ID do _removeTransaction)

  final void Function(String) onRemove;

  e iremos comocar ela no parametro para não termos problema
  
  TransactionList(this.transactions, this.onRemove);


  após isto, iremos modificar o "onPressed" do trailing para retornar o tr.id, chamando o "onRemove"
  que foi recebido pelo contrutor, que é o _removeTransaction, o onRemove recebe o parametro tr.id
  que por sua vez vai subindo ate chegar no método "_removeTransaction" que faz a verificação
  se é o mesmo id e remove
  onPressed: () => onRemove(tr.id),




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
  final List<Transaction> _transactions = [];

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

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere(
        (element) {
          return element.id == id;
        },
      );
    });
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
          Chart(_recentTransactions),
          TransactionList(_transactions, _removeTransaction),
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
