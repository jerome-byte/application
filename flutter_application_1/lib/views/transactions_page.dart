import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/transaction_card.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: ListView.builder(
        itemCount: wallet.transactions.length,
        itemBuilder: (ctx, i) =>
            TransactionCard(transaction: wallet.transactions[i]),
      ),
    );
  }
}
