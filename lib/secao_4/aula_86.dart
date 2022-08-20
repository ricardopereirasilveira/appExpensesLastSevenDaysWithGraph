/*
  86. Column & Row

  Column 
    Eixo Principal (Main Axis - Vertical) // Principal
    Eixo Cruzado (Cross Axis - Horizontal)
  
  Row
    Eixo Principal (Main Axil - Horizontal) // Principal
    Eixo Cruzado (Cross Axis - Vertifal)

  O eixo principal do tipo Coluna é o eixo vertical, que representa a coluna
  e em relação ao eixo principal, temos diversas posibilidades de como iremos
  organizar o layout dos elementos, ou seja, temos o elemento da coluna.

  Já quando temos um elemento tipo ROW, os elementos estão invertidos 
  onde o eixo principal da linha será o horizontal e o eixo cruzado será o vertical

  Os eixos precisam ser entendidos para saber quais são os principais dependendo
  do que estivermos trabalhadndo (column ou row), então teremos uma série 
  de possibilidades para cruzar os elementos na tela.

  no Column, por padrão ele vem setado
    mainAxisAlignment: mainAxisAlignment.start, // eixo vertical
    crossAxisAlignment: CrossAxisAlignment.center // eixo horizontal

  podemos colocar:
    mainAxisAlignment: MainAxisAlignment.spaceAround 
    e ele irá colocar o espaço em volta do elemento no eixo Main (vertical)
    então ele irá colocar um espaço acima e abaixo de cada elemento onde foi inserido

    mainAxisAlignment: MainAxisAlignment.spaceBetween
    ele não ira colocar antes e nem depois, ele irá colocar espaço entre os elementos  

    mainAxisAlignment: MainAxisAlignment.end
    irá colocar tudo o mais pra baixo possível






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
            const Card(
              child: Text("Lista de Transações"),
            )
          ],
        ));
  }
}
