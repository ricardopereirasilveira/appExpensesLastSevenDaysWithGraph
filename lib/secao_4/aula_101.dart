/*
  101. Usando TextFields

  Vamos começar a desenvolver a tela que irá cadastrar uma nova transação
  a classe 
  TextField() insere um campo de texto inserivel, nele temos algumas opções
  para podermos inserir valores

   decoration: InputDecoration(
      labelText: "Valor (R\$)",
    )

  Neste ele irá inserir um texto para ajudar o usuário a inserir o o que o campo
  está esperando

  Pegando dados do TextField

  Com Stateless não é indicado criar varivaveis que recebam valores, elas tem
  que ser final para serem compiladas quando rodado o programa 

  evento:
    onChanged: (newValue) => title = newValue
  sempre que mudar, vamos pegar o valor modificado e setar nessa variavel
  ele recebe uma função que retorna void, mas que como parametro recebe uma String
  então conseguimos receber a string que esta no TextInput e setar ela em uma variavel

  Esta não é a melhor estrategia, porque estamos colocando valores mutaveis
  dentro da classe que é imutavel

  A outra maneira que faremos, é a maneira mais efeciente, e mesmo assim, colocando
  como final, iremos alterar o estado interno dessa variavel, segue abaixo as novas
  variaveis:  
    final titleController = TextEditingController();
    final valueController = TextEditingController();

  Embora marcamos como final a variaveis, o App não ira ficar reclamando, porém
  o estado interno de TextEditingController ficara mudando, conforme digitação

  Agora, uma vez que muda, estado dentro do controller vai sendo alterado a 
  partir do momento em que digitamos as inforamções no Input
*/

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

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
                        'R\$ ${tr.value.toStringAsFixed(2)}',
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
                          DateFormat('d MMM y').format(tr.date),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ));
              }).toList(),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Titulo",
                      ),
                    ),
                    TextField(
                      controller: valueController,
                      decoration: const InputDecoration(
                        labelText: "Valor (R\$)",
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        print(
                            "${titleController.text} e ${valueController.text}");
                      },
                      child: const Text("Nova Transação"),
                      textColor: Colors.purple,
                    )
                  ]),
                ),
              ),
            )
          ],
        ));
  }
}
