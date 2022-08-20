/*
  108. Teclado númerico

  Dentro do formulário de INPUT (transaction_form.dart) dentro do
  TextField temos um parametro nomeado chamado "keyboardType" e nele
  podemos chamar a classe TextInputType.number

  porém, no Android apenas o .number irá funcionar, mas no iOS ele
  irá mostrar apenas os números, então podemos colocar de outra
  maneira que é
  keyboardType: TextInputType.numberWithOptions(decimal: true),

  Desta forma irá funcionar não apenas no Android, como no iOS dando
  a oportunidade para o usuário selecionar as casas decimais

  Outra coisa que podemos fazer é ao usuário clicar em submeter direto
  do teclado número, a informação ir para onde é necessária (Transaction)
  sem precisar clicar em "nova transacão".

  Para isto criamos uma nova função '_submitForm' que irá submeter o 
  formulário e inclusive validar se alguma informação esta faltando
  caso contrário ele irá retonar absolutamente nada, senão ele chama
  o 'onSubmit' passando os parametros

  Temos um parametro nomeado chamado "onSubmitted" que irá submeter as
  inforamções enviadas através do tick do teclado que foi aberto
  ela recebe uma função então podemos passar o value através do
  _submitForm()

  onSubmitted: (value) => _submitForm(),

  caso não queira usar o "value" da arrow function acima, nós
  podemos usar um "_", este é um padrão usado no flutter e em 
  outras linguagens quando não vamos usar o valor que vamos receber na
  arrow function, ficando assim

  onSubmitted: (_) => submitForm(),
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
