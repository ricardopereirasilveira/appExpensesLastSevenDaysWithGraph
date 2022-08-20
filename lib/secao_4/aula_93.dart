/*
  93. Aplicando Estilo no Container

  Diferente de outras tecnologias do mercado, o Flutter não tem outra linguagem
  a parte para a gente aplicar estilo, nós aplicamos estilo usando os widegets/apis
  do flutter 

  OBS: Nós podemos refatorar uma parte dando um "CMD + ." e "Remove this Widget"

  Container(
    margin: const EdgeInsets.symmetric( // definimos as bordas como simetricas
      horizontal: 15, // a horizontal vai ser maior que a vertical 
      vertical: 10,
    ),
    child: Text(tr.value.toString()),
  ),

  Outro atributo nomeado que iremos usar no Container é o "decoration", que irá chamar
  o widget BoxDecoration 

  decoration: BoxDecoration(
      border: Border.all(
    color: Colors.black,
    width: 2,
  )),

  Ele irá fazer uma borda total com a cor preta da expessura de 2px

  A proxima coisa que faremos é o padding
    margin: largura do lado de fora (após a borda)
    padding: largura do lado de dentro (antes da borda )

    Conteudo > Padding (antes da Borda) > Borda > Margin (após a borda)
  
  padding: const EdgeInsets.all(10)

  aqui ele está adicionando um padding com a lagura de 10px para o conteudo (assim a borda não fica
  grudada no conteudo, pois com o margin ele só irá colocar os elementos de fora assim)

  A idéia por trás de um container é exatamente a possibilidade que usando o container
  ele da a possibilidade de colocar estilos personalizados, como um margin(margem),
  borda, padding, etc. Isto não está disponível por padrão no Text()

  Se quisermos colocar so espaçamento externos, nós temos um componente especifico que é o
  padding, então podemos dar um espaçamento entre um componente e outro mas se precisarmos
  decorar de forma mais detalhada colocando bordas e outros elementos, teremos que usar o
  Container()
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
                        color: Colors.black,
                        width: 2,
                      )),
                      padding: const EdgeInsets.all(10),
                      child: Text(tr.value.toString()),
                    ),
                    Column(
                      children: [
                        Text(tr.title),
                        Text(tr.date.toString()),
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
