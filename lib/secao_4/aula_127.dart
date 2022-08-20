/*
  127. Flexible & Expanded

  Flexible e expended estão fortemente ligados com o conceito de FlexBox, o FlexBox em sí é muito
  usado no Flutter como na WEB.

  Flexible:
    No Flexbible existe o parametro nomeado chamado "fit:"
    
    Flexible(
      fit: FlexFit.loose
    )
    Com o fit de FlexFit, ele vai manter as configurações "originais" e irá obedecer basicamente o
    width, então, basicamente o elemento não irá sofrer alteração, ele irá apenas se adequar ao que
    tem dentro dele, mantendo o tamanho definido internamente.

    Flexible(
      fit: FlexFit.tight
    )
    Tight é algo como "apertado", ou seja, quando colocado dentro de um elemento, ele irá "preencher"
    todos os espaços em branco que contenham até que não fique mais nenhum espaço em branco, ele irá
    "expandir" ate ficar sem espaço em branco entre elementos

    Se colocarmos dois elementos como "tight" ambos irão concorrer (e por causa disso, irão dividir) os
    espaços em branco

    Caso dois elementos tenham o FlexFit.tight, eles irão dividir, porém podemos colocar quem tem mais
    prioridade em cima de outro componente. 
    Para isto, usaremos o parametro nomeado "flex:" que por padrão, vem com o valor de "1"

    Flexible(
      flex: 1
    )
    
    assim, ele é por default, ou seja, irá dividir os elementos caso haja mais de um com o Flexible


    Flexible(
      flex: 2
    )
    Com o "flex: 2" NÃO significa que ele terá o dobro do 'flex: 1', o que acontece é que, a tela está
    sendo dividida em 3 partes, com isto, o primeiro flex, 'flex:1' ficará com 1/3 das partes em branco
    e o segundo flex 'flex:2' ficara com 2/3 das partes em branco

    se colocarmos ambos os elementos com o 'flex: 2', ele irá dividir de novo, porque ele irá dividir
    a parte em branco por 4, e então cada parte ficará com 2, sendo uma conta exata e ficando as partes iguais
    ficando 2/4 para cada elemento.

    Ou seja, somamos os valores em "flex" dos elementos da mesma ROW/COLUMN e então dividimos pela quantidade
    de elementos e fazemos a divisão através dos valores do FLEX

    Com isto, vamos modificando os valores flex para ir definindo quem tem a maior prioridade em nos
    elementos em branco

    se nós colocarmos um elemento "fit: FlexFit.loose" e colocar o "flex: 1" e em outro o tight e o flex de 4
    (por exemplo), o flex com 4 irá respeitar e dar um "espaço em branco" para o elemento, usando apenas o
    necessário (neste caso, 4/5)

  * Expanded:
    É exatamente a mesma coisa que o "Flexible" porém com a propridade "fit" já setada para "FlexFit.tight"
    com isto não podemos altera-lo

    Expanded(
      flex: 4,
    )

    Acabamos usando mais o Expanded, porque não precisamos colocar uma propriedade a mais


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
