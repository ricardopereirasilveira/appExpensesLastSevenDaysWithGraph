/*
  97. Container vs Column/Row

  Diferença conceitual entre Container e Column/Row

  Container:
    - Aceita exatamente um widget como filho (atributo child)
    - Alinhamento flexível e opções de estilo, sempre que quisermos fazer um estilo dentro
      de um componente, use o Container (exemplo: decorator), se o Text() não tiver um 
      determinado estimos que queremos, podemos envolver ele dentro de um Container(Text(""))
      e fazemos o estilo que queremos
    - Largura flexível (ex: largura do filho, largura disponível)
    - Perfeito para alinhamento e estilo personalizado

  Column/Row
    - Aceita uma lista de Widgets como filhos (atributo children)
    - Alinhamento, porém sem opções de estilo
    - Sempre ocupa toda altura (Column) como também sempre ocupa toda largura (Row)
      porém isto não significa que não podemos esticar, no caso da Column (eixo vertical)
      nós podemos usar a propriedade crossAlignment para fazer o ajuste no eixo cruzado
      colocando, por exemplo, o stratch que ele irá esticar, a mesma coisa acontece na linha
      porém invertendo o eixo
    - Usando quando os Widgets estiverem próximos ou acima um do outro
  
  OBS: Quando queremos colocar um elemento do lado do outro, usaremos a Row e quando queremos
  colocar um elemento em cima do outro, usaremos o Column


*/

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      )),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        tr.value.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          tr.date.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
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
