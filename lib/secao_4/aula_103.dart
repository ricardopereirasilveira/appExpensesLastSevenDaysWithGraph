/*
  103. Dividindo App em Widgets

  para começar a dividir os Widgets nós iremos criar uma nova pasta chamada
  "components" dentro de lib

  - lib
    - components

  dentro do components, criamos um arquivo chamado "transaction_list.dart"
  a ideia é enviar para esse componente a lista de transações

  --> transactions_list.dart
    Nele iremos criar uma lista de transactions, e o construtor ira receber
    esta lista e armezanar ela na varivel criada
    A ideia é jogar todo o código que se refere as transações e tratar as inforamções
    por lá e teremos a lista de transações de volta e com um componente
    a parte

  --> transaction_form.dart
    Também iremos criar um componente do tipo stateless e enviaremos o formulário
    para dentro dele, retornando ele no main.dart

  --> transaction_user.dart
    Ele é temporario, é apenas para receber os dados da Transaction
    ele é um componente StatelessFull, porque vamos precisar mexer
    em cima da lista criada em _transactions, que embora seja final
    o conteudo da lista pode ir aumentando, ela é final porque não
    podemos mexer na referencia pra variavel _transaction mas podemos
    mexer na lista (cadastrar novos elementos, excluir elementos)

  Refatoração: Temos o componente principal (main.dart, ExpensesApp) que dentro
  tem o MaterialApp que no Home chama o MyHomePage, temos a parte azul (gráfico)
  que ainda esta no main.dart, dentro do Container, que leva a maior linha de
  código. 
  Então temos o TransactionUser, sendo um componente statefull, pois o usuário
  ira mexer no formulário e será notificado o TransactionUser e automaticamente
  ele irá adicionar uma nova transação nesta lista (_transactions)

  ExpensesApp > MyHomePage > TransactionUser > TransactionList / TransactionForm
  
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
        ));
  }
}
