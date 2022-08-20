/*
  107. Usando ListView

  Um padrão extremamente comum dentro de uma aplicação é ter uma lista de elementos
  que precisam ter o scroll, e como é um padrão relativamente comum, pois nem
  todas as aplicações tem o tamanho exato da tela, então para isto temos o
  ListView

  Neste caso iremos modificar a Column pelo ListView

  O ListView assim como o SingleChildScrollView precisa que o componente pai
  tenha um tamanho pré definido, caso não tenha ele ira gerar uma exception 
  "Vertical viewport was given unbounded height" e não irá compilar o componente

  Vale dizer que, se tivermos mil elementos (por exemplo), o Flutter irá renderizar
  os mil elementos, mesmo que eles não estejam visiveis na tela por causa do scroll
  e eventualmente isto irá ocupar muita memoria do celular, ou seja, a aplicação irá
  ficar lenta, vai ocupar muita memoria e a experiencia do usuário não será boa

  Por isto temos uma forma melhor de trabalhar com o ListView que é passando o método
  builder()

  ListView.builder(
    itemCount: transactions.lenght,
    itemBuilder: (ctx, index) {
      final tr = transactions[index];
      ....final do código aqui
    };
  )

  Ou seja, todos os elementos que estiverem fora da tela não serão pré renderizados
  só serão renderizados conforme forem sendo solicitados e isto irá enconomizar bastante
  memoria da nossa aplicação.

  Se temos uma lista que sabemos que não é grande, e não irá levar muito tempo para renderizar
  podemos passar apenas o ListView, mas se não sabemos o tamanho da lista ou ela for muito
  grande, o ideial é sempre chamar o ListView.builder informando os dois parametros nomeados
  itemCount e itemBuilder



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
      ),
    );
  }
}
