import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList({Key key, this.transactions, this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        child: LayoutBuilder(
      builder: (context, constraints) {
        return transactions.isEmpty
            ? _errorWidget(context, constraints)
            : _listTransaction(context, constraints);
      },
    ));
  }

  Widget _errorWidget(BuildContext context, BoxConstraints constraints) {
    return Column(
      children: <Widget>[
        Text(
          "No Transactions added yet!",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _listTransaction(BuildContext context, BoxConstraints constraints) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final item = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text("\$${item.amount}"),
                ),
              ),
            ),
            title: Text(
              item.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(item.date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTx(item.title),
            ),
          ),
        );
      },
    );
  }
}
