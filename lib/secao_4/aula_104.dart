/*
  104. Adicionando Transação

  Iremos fazer a transação entre inserir um novo item no formulário
  e adicionar o item na lista e quem irá fazer a transação entre 
  esses componentes, será o transaction_user.dart e iremos verificar
  o conceito de comunicação direta e comunicação indireta

  comunicação direta: É quando temos um pai, que passa o componente
    para o filho ser renderizado, por exemplo, o TransactionList
    depende da lista de transações (_transactions), se mandarmos uma
    lista vazia TransactionList([]) ele irá parar de mostrar as
    transações 
    O dono das transações é o transaction_user.dart, pois ele tem as
    informações e passa, via parametro (Construtor), para outro
    componente (filho) esta lista para ela possa ser renderizada 
  
  comunicacão indereta: É quando o filho precisa notificar o pai
    ou seja, o TransactionForm precisa ser notificado da transação
    e posteriormente passar essa informação para o TransactionList

  transaction_user.dart
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
  }

  Esta função irá criar uma nova transação, recebe dois parametros e 
  instancia a classe Transaction que recebe os parametros nomeados
  e então envia os valores recebidos
  Então, dentro de um setState (já que é uma stateful) nós iremos 
  adicionar dentro de _transactions o newTransaction (criado anteriormente
  dentro da mesma função) e estando dentro de um statful já que a árvore
  de componentes irão atualizar nós podemos usar atraves do setState
  

  * Quando temos um parametro STATELESS a unica coisa que pode alterar ele
  é passar uma parametro para o construtor daquele componente STATELESS ou seja
  externamente, o dado mudou e passamos essa informação para um componente
  STATELESS e então o componente se atualiza

  * Quando temos o STATEFUL, nós podemos alterar de duas formas
    1. Externamente, alguém alterou algum parametro que estamos recebendo via
    construtor de um componente STATEFUL ou o estado daquele componente alterou
    e então conseguimos renderizar novamente
    2. A partir do estado mudando (setState)
  
  Agora iremos fazer a integração através de dois componentes filhos (
  TransactionForm e TransactionList) e o componente pai que unes os dois
  (TransactionUser) e iremos fazer a integração através dele

  Agora iremos estabelecer uma comunicação indireta, pois o TransactionForm
  precisa conversar com o pai dele (TransactionUser), então a gente espera
  receber uma função, com isto vamos no construtor 

  --> transaction_form.dart
  dentro de TransactionForm nós criamos uma variavel que recebe uma função
  chamada "onSubmit" que irá receber dois parametros (uma string eum double)

  final void Function(String, double) onSubmit;
  TransactionForm(this.onSubmit);

  com isto, no "transaction_user.dart" nos colocaremos o seguinte código
    TransactionForm(_addTransaction),
  que irá receber o _addTransaction, que é o parametro que chama a classe
  Transaction e adiciona dentro de _transaction o valor passado (através
  dos parametros da função)

  no transaction_form.dart no onPressed nós temos a seguinte função
  onPressed: () {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    onSubmit(title, value);
  },

  isso significa que o componente filho, passo uma função para o componente pai
  através da função onSubmit, que passou a partir do construtor.
  Se olharmos no TransactionUser, ao chamar o TransactionForm nós apssamos o 
  _addTransaction (função que espera receber como parametro) e então dentro do
  TransactionForm nós recebemos a função e neste caso do TransactionForm nós
  chamaos de onSubmit e dentro do componente nós sabemos o momento certo
  que o usuário quer submeter uma nova transação e chamamos atrvés do onPressed
  nos recebemos os parametros (title e value) e então chamaos o onSubmit 
  que esta aguardando uma String e um double que é exatamente no TransactionUser
  irá receber uma String e um double

  Agora podemos adicionar as transações, porém se dermos um hot realod, ele irá
  apagar todas as transações criadas e irá deixar apenas para as duas fixas que
  criamos inicialmente 

  OBS:
  //double.tryParse(valueController.text) ?? 0;
  no tryParse nós tentaremos passar um valor como double, caso negativo (??) ele
  irá passar o valor zero//

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
