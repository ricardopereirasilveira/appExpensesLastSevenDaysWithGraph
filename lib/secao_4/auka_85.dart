/*
  85. Criando o projeto;

  Neste projeto iremos criar as despesas pessoas e nesta primeira versão
  criamos apenas o ExpensesApp com o MaterialApp e passamos o MyHomePage
  que é outra classe Stateless e nela colocamos o Scaffold e então criamos
  a AppBar com o titulo e no texto apenas um texto simples introdutório.

  Segue código abaixo:

*/

import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
      ),
      body: const Center(
        child: Text('Versão Inicial'),
      ),
    );
  }
}
