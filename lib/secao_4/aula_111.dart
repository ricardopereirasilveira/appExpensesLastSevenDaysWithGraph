/*
  111. Parametros em Stateful Widget

  Quando temos um componente sem estado, ele é representado em uma única classe
  que tem o método build, e é justamente esse método que irá retornar os 
  widgets que retornam os componentes.

  Quando transformamos um componente sem estado (Stateless) para um componente
  com estado (Stateful) nós passamos a ter duas classes 
    1. A primeira classe é a que representa o estado
    2. A outra classe é a que representa o componente Stateful

  Precisamos ter uma comunicação entre as duas classes, já que não é apenas uma
  classe.

  O componente que foi transformado de Stateless para Stateful recebe um parametro
  via construtor (onSubmit no caso) que é uma função. Ainda quando formos declarar
  esse componente (chamar ele) nós ainda continuamos chamando através da classe
  (referenciando o widget), seja ele Stateful ou Stateless, obrigatoriamente quando
  fomos referenciar o componente (instanciar a classe) nós sempre iremos fazer isto
  com a classe (no exemplo, o TransactionForm), que é o unico que está sendo exposto
  na classe transaction_form.dart ja que a outra classe (_TransactionFormState) é
  privada

  Agora, nós vamos precisar usar a função (onSubmit) na classe _TransactionFormState
  que esta extendendo de TransactionForm, e para fazer isto, existe uma propriedade
  que é recebida por herança, herda um atributo chamado "widget" e esse atributo
  aponta para uma instancia da classe pai (TransactionForm) então ele pode usar
  o onSubmit na classe herdada, então podemos acessar a receber a função que foi recebida
  como parametro

  A parte do build foi transferida pro State (_TransactionFormState) ja que ele que irá
  formar a árvore é dependente do estado, ou seja, quando a classe muda o build precisa
  ser rodado novamente para atualizar os componente visuais, por isto o build foi
  transferido do componente (TransformForm) para o State (TransformFormState) 

  E ainda temos temos acesso a classe TransformForm através da variavel "widget"

  Por isto, não existe problema em criarmos quantos parametros forem necessários para
  receber na classe Stateful, pois teremos acesso através da variavel "widget"


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
