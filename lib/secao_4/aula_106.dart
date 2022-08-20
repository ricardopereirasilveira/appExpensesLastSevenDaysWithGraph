/*

  106. Lista com Rolangem (Scroll)

  Habilitando o scroll, pra quando os elementos da página forem maior que 
  o elemento visto, conseguimos habilitar o scroll, pois atualmente
  quando o teclado sobe (ou tem muitos itens na página) ele fica em cima do
  elemento

  1. A primeira coisa que podemos fazer, é envolver a primeira Column (do Body
  do Scaffold), podemos dar um wrap com um widget e modificar o widget para
  'SingleChildScrollView', ele será o responsável por tonar a tela scrollable
  ou seja, possível de fazer o scroll
  Nós podemos colocar o SingleChildScrollView dentro de outros componentes, porém
  se ele não for o pai do componente, deve ser necessário colocar o height para poder
  inserir da maneira certa, e em alguns casos, mesmo com ele no elemento filho
  ele ainda deve quebrar a aplicação

  Pro componente SingleChildScrollView o pai precisa ter um tamanho pré definido

  o SingleChildScrollView é um componente que aeita um único elemento (child)
  
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
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }
}
