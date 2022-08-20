/*
  132. Exibinodo DatePicker

  Iremos criar uma função para colocarmos, dentro do modal, para escolhermos a data

  Para isto, o flutter tem o widget pronto para ser usado chamado "showDatePicker"
  que recebe o context (da propria build) e também três parametros nomeados obrigatoriamente
  que são o initialDate, firstDate e lastDate

  initialDate = data inicial onde, ao abrir o modal, ela será selecionada
  firstDate = a primeira data que podera ser inserida no formulário, ao inserir o ano
    não é possível selecionar, neste caso, alguma data anterior a 2019
  lastDate = até qual data pode ser colocado informações no formulário, neste caso
    esta definido para colocar até a data atual (sem poder colocar data futura)
  
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    );
  }

  e então no 'onPressed' podemos colocar o "_showDatePicker" sem os parateses e assim
  ele irá abrir o modal contendo a data

  Agora iremos pegar (e armazenar) a data e usa-la dentro da aplicação

  o que acontece:
  Quando chamamos o showDatePicker (quando o usuário clica em "selecionar data"), a
  primeira coisa que vamos entender é que a função retorna um Future<DateTime> (um
  futuro), isto significa que estamos trabalhando com dados asyncronos, ou seja, pode
  retornar algo no futuro, então, para trabalhar com algo no futuro e para isto, 
  dentro do Future temos uma função chamada ".then(onValue)"

  Então, o onPressed irá executar a "showDatePicker" e então irá terminar sua função
  ai o ".then()" irá esperar pela resposta do formulário, sendo assim, o software
  irá continuar rodando, porém o .then irá ficar "aguardando" a resposta

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  então estamos usando o "showDatePicker" que é um Widget do Flutter já existente
  que irá receber os parametros nomeados obrigatórios, e em seguida irá chamar o ".then"
  pois o "showDatePicker" é um "Future" ou seja, é asincrono, então ele não irá esperar
  o usuário inserir a data, com isto, quando o usuário selecionar ele irá passar pelo
  "if" e irá, através do setState (pois é uma mudança de estado) inserir a data dentro do
  pickedDate, esta dentro do setState pois é uma alteração de estado, então é necessário
  atualização dos gráficos


*/

import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transacton_form.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 'T0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 'T1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 'T20',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

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

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Chart(_recentTransactions), TransactionList(_transactions)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
