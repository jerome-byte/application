import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final sign = transaction.type == 'Deposit' ? '+' : '-';
    final color = transaction.type == 'Deposit' ? Colors.green : Colors.red;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha((0.1 * 255).round()),
          child: Icon(
            transaction.type == 'Deposit'
                ? Icons.arrow_downward
                : Icons.arrow_upward,
            color: color,
          ),
        ),
        title: Text(transaction.type),
        subtitle: Text(transaction.date.toLocal().toString()),
        trailing: Text(
          '$sign${transaction.amount.toStringAsFixed(2)} €',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
