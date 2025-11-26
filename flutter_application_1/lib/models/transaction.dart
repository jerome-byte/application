class TransactionModel {
  final String id;
  final String type; // 'Deposit' | 'Withdrawal'
  final double amount;
  final DateTime date;
  final String status; // 'Completed' | 'Pending' | 'Failed'

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.status = 'Completed',
  });
}
