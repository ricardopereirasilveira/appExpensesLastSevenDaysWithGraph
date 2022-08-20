/*
  85. Combinando Widgets
  
  Componente tipo Card():
    Iremos colocar dois gráficos inicialmente em nossa aplicação 
    apenas para diferenciarmos onde irão cada item (gráfico + lista 
    de transações)   

  Dentro de Card temos o parametro nomeado chamado "elevation", se
  colocarmos ele, ele da aquela impressão de estar saindo da tela (3D)
  por conta do sobreamento, dando a impressão de estar suspenso dentro
  da tela

  Para colocar o card na tela inteira nós iremos envolver o Card em um
  Container() e então iremos inserir um width e colocar um 
  double.infinity

  Container (
    width: double.infinity,
    child: Card(
      ...
    )
  )

  Neste momento os elementos foram colocados no centro, então se nós quisermos
  modificar o eixo X (crossAxis) basta adicionarmos o parametro nomeado
  dentro do Colum

  body: Column(
    crossAxisAlignment: CrissAxilAlignment.end // esta parte ira jogar o texto todo para esquerda
    crossAxisAlignment: CrissAxilAlignment.start // esta parte ira jogar o texto todo para direita
    crossAxisAlignment: CrissAxilAlignment.center // esta parte ira jogar o texto todo para centro
  )


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
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                child: Text("Gráfico"),
                elevation: 5,
              ),
            ),
            const Card(
              child: Text("Lista de Transações"),
            )
          ],
        ));
  }
}
