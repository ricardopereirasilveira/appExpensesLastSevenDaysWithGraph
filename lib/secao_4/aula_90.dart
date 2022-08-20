/*
  90. Mapear Dados para Widgets

  Agora a idéia é exibir as duas transações criadas na interface
  gráfica fazendo um map, convertendo isso para lista em elementos
  visuais

  A idéia é converter um objeto do tipo transaction para um componente
  visual 

  Column(
    children: _transactions.map((e) {
      return Card(
        child: Text(e.title),
      );
    }).toList(),
  )
  Aqui já estamos colocando diretamente o resultado do map dentro de 
  children 

  aqui estamos pegando todos os elementos de _transactions e colocando
  em um map, que irá retornar um card com o titulo de cada, transformamos
  o map é uma lista com o .toList()
  Tudo isso, dentro de um Card () que foi retornado dentro do Column

  outra forma é:

  Column (
    children: [
      ..._transactions.map((tr) {
        return Card(
          child: Text(tr.title),
        );
      }).toList()
    ],
  )

  o "..." significa que estamos "espalhando", ou seja, pegando o resultado
  da lista e pegando cada um dos elementos e colocando dentro de outra lista

  Embora a segunda seja válida, não precisamos usar a segunda estrategia
  para fazer isto, pois podemos simplismente já colocar diretamente 
  associado o widget o resultado da função do map

  Aqui pegamos objetos que não são visuais, pois são simplismente transações
  (Transactions) e convertemos eles para elementos visuais para mostra
  na tela usando a função map

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
              children: _transactions.map((e) {
                return Card(
                  child: Text(e.title),
                );
              }).toList(),
            )
          ],
        ));
  }
}
