/*
  91. Item Lista Personalizado

  - Como iremos definir o componente personalizado para cada um dos elementos
    que iremos mostrar na lista de transações

  Iremos usar o Card, Row, Column e o Container

  Iremos trabalhar no retorno do Card

  Column(
  children: _transactions.map((tr) {
    return Card(
        child: Row(
      children: [
        Container(
          child: Text(tr.value.toString()),
        ),
        Column(
          children: [
            Text(tr.title),
            Text(tr.date.toString()),
          ],
        )
      ],
    ));
  }).toList(),
)

Neste momento temos um map que envia, individualmente os valores de Transactions
através do tr, criamos um Card que dentro tem uma Row, que por sua vez, ao lado esquerdo
fica o Container enviando o valor da transação (foi necessário transformar em toString)
após o Container, mas dentro da Row, temos o Column que esta recebendo o titulo e a data
que também foi convertido para toString

do lado esquerdo temos o valor da transação e do lado direit temos o titulo e a data

*/

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
      id: 'T1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Despesas Pessoais"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: const Card(
                color: Colors.blue,
                child: Text("Gráfico"),
                elevation: 5,
              ),
            ),
            Column(
              children: _transactions.map((tr) {
                return Card(
                    child: Row(
                  children: [
                    Container(
                      child: Text(tr.value.toString()),
                    ),
                    Column(
                      children: [
                        Text(tr.title),
                        Text(tr.date.toString()),
                      ],
                    )
                  ],
                ));
              }).toList(),
            )
          ],
        ));
  }
}
