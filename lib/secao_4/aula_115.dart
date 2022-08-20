/*
  115. Estilo com Theme

    color: Theme.of(context).colorScheme.primary,
  
  Se não usarmos o Theme teremos que escolher especificamente em cada componente
  as cores ou estilos especificos

  No MaterialApp temos um atributo nomeado chamado "theme" que irá receber uma
  classe/componente chamado ThemeData que por sua vez tem outro atributo nomeado
  chamado

  diferença entre primaryColor e primarySwatch
    primaryColor: Recebe uma cor como parametro
    primarySwatch: Recebe uma MaterialColor
  
  diferença entre Color e MaterialColor
    color: Aqui estamos setando apenas uma única cor como sendo a cor primaria

    MaterialColor: É um conjunto/lista de cores dentro de um mesmo spectrum
    de cor (por exemplo, temos uma cor ROXA, temos um roxo intermediario e temos
    alguns roxos mais claro e também alguns roxos mais escuros, teremos um range
    de cor dentro do MaterialColor). No MaterialColor não estamos passando apenas
    uma única cor e sim um conjunto de cores dentro
  
  Agora, salvando a aplicação ela começa a dar cores baseado na cor especifica
  dentro do APP, porém, uma cor especifica dentro de um componente tem alta
  prioridade em cima do primarySwatch (o tema é generico por isso tem baixa
  prioridade)

  e Para usar a cor padrão do Theme (primarySwitch) nós temos que definir a cor do
  elemento como:
    color: Theme.of(context).colorScheme.primary,
  
  Outro atributo que iremos usar é a cor de destaque/realce, usando o atributo
  nomeado chamado "accentColor", ficando assim:
    accentColor: Colors.amber,
  
  Agora, o botão de "+" ganhou o destaque e ficou amarelo

  theme: ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.amber,
  ),


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
