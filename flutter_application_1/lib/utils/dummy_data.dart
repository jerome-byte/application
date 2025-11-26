import '../models/transaction.dart';

final double initialWalletBalance = 500.0;

final List<TransactionModel> dummyTransactions = [
  TransactionModel(
    id: '1',
    type: 'Deposit',
    amount: 100.0,
    date: DateTime.now().subtract(Duration(days: 1)),
  ),
  TransactionModel(
    id: '2',
    type: 'Withdrawal',
    amount: 50.0,
    date: DateTime.now().subtract(Duration(days: 2)),
  ),
  TransactionModel(
    id: '3',
    type: 'Deposit',
    amount: 200.0,
    date: DateTime.now().subtract(Duration(days: 3)),
  ),
];
