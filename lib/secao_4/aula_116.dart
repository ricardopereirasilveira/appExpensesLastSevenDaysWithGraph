/*
  116. Fontes Personalizadas e Theme

    Theme.of(context).textTheme.headline6

  Instalando fontes externas:
  A primeira coisa, é fora da Lib(uma pasta antes) nós podemos criar uma fonte
  chamada assets (recursos em inglês) e dentro de assets vamos criar uma pasta
  chamada "fonts"

  Expenses
    -> assets
      -> fonts
  
  Dentro da pasta fonts, podemos jogar todas as fontes personalizadas que iremos
  usar no projeto.

  Agora dentro do pubspec.yaml iremos "registrar" todos os nomes de fontes que
  vamos usar no projeto, no exemplo, registrando a Opensans e a Quicksand

  fonts:
    - family: OpenSans
      fonts:
        - asset: assets/fonts/OpenSans-Regular.ttf
        - asset: assets/fonts/OpenSans-Bold.ttf
          weight: 700
    - family: Quicksand
      fonts:
        - asset: assets/fonts/Quicksand-Regular.ttf
        - asset: assets/fonts/Quicksand-Bold.ttf
          weight: 700

  Ao instalar a fonte, é recomendado que se reinicie a aplicação

  Então, dentro de ThemeData, temos um atributo nomeado chamado "fontFamily"
  que irá receber o nome da fonte, cadastrado no pubspec.yaml (mesmo nome)
  neste caso, colocamos a Quicksand, então o código ficara assim

    theme: ThemeData(
      fontFamily: 'Quicksand',
    )
  Assim, todas as fontes da aplicação ficam com Quicksand

  Nós podemos também modificar algo especifico (por exemplo a AppBar)
  para isto, basta adicionar no Text o atributo nomeado style que recebe um TextStyle
  e com o atributo nomeado fontFamily inserir a fonte

  exemplo:

  appBar: AppBar(
    title: Text(
      'Despesas Pessoais',
      style: TextStyle(
        fontFamily: 'OpenSans'
      )
    )
  )

  Nós podemos fazer isto a partir do tema também, e modificar exatamente o appBar
  através do atributo nomeado (dentro de ThemeData) chamado 'appBarTheme'
  chamando a classe AppBarTheme e passando o atributo nomeado textTheme
  

  textTheme: ThemeData.light()
    todas as propriedades são setadas para usar o tema padrão de cor default do Flutter

  Nós podemos modificar também o title através do ThemeData, usando o
  titleTextStyle passando a classe TextStyle que por sua vez tem o atributo nomeado
  fontFamily

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

  

  Nós podemos modificar coisas especificas, como por exemplo no Title dentro de
  transaction_list.dart e dentro da propriedade style (que ta dentro de Text)
  nós podemos inserir o código
    Theme.of(context).textTheme.headline6

  Que ele ira pegar os valores baseados no Tema

  Dentro do ThemeData temos também o textTheme (parametro nomeado) que por padrão
  pode ser modificado (igual ao appBarTheme) e ele irá enviar o padrão para todos
  os textos do texto


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
