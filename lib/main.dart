// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:my_app/widgets/chart.dart';
import 'package:my_app/widgets/new_tansaction.dart';
import 'package:my_app/widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(Tracker());

class Tracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'OpenSans',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      title: 'Elnas',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'u1',
    //   title: 'Shoes',
    //   amount: 69.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'u2',
    //   title: 'Clotha',
    //   amount: 999.9,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'u3',
    //   title: 'shirta',
    //   amount: 999.9,
    //   dateTime: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      dateTime: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(_addNewTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
        title: const Text('Elnas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTransaction),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),

      //Added FloatingActionButton

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
