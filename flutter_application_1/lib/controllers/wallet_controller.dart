import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../utils/dummy_data.dart';

class WalletController extends ChangeNotifier {
  double _balance = initialWalletBalance;
  final List<TransactionModel> _transactions = List.from(dummyTransactions);

  double get balance => _balance;
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  List<TransactionModel> get latestThree {
    final copy = List<TransactionModel>.from(_transactions);
    copy.sort((a, b) => b.date.compareTo(a.date));
    return copy.take(3).toList();
  }

  void deposit(double amount) {
    if (amount <= 0) return;
    _balance += amount;
    _transactions.insert(
      0,
      TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: 'Deposit',
        amount: amount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  bool withdraw(double amount) {
    if (amount <= 0 || amount > _balance) return false;
    _balance -= amount;
    _transactions.insert(
      0,
      TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: 'Withdrawal',
        amount: amount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
    return true;
  }
}
