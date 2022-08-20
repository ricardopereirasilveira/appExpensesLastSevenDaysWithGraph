/*
  109. Botões para adicionar transação

  Agora iremos adicionar os botões para acionar o modal quando queremos adicionar
  uma nova transação, o primeiro que faremos é no appBar.
  Iremos adicionar uma actions que recebe uma lista de Widgets e então adicionaremos
  o IconButton que recebe um parametro nomeado chamado icon que recebe um componente
  (classe) Icon, que dentro é chamado o parametro nomeado Icons."nome do botão"

  Se nós clicarmos em Icon(Icons."nome do botao") e tem um "i" que podemos ter um
  preview do botão

  actions: [
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () {},
    ),
  ],

  E também faremos, na parte inferior um floatingActionsButton para adicionar um
  botão flutuante, na parte do body do Scaffold

  floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {},
  ),

  Outra possibilidade que temos é modificar o local onde o FloatingButton esta localizado
  modificando através de outra propriedade chamada floatingActionButtonlocation
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  
  Este é um parametro nomeado do Scaffold
  
*/

import 'package:expenses/components/transaction_user.dart';
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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
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
          TransactionUser(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
