import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/controllers/wallet_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WalletController', () {
    test('deposit increases balance and adds transaction', () {
      final wallet = WalletController();
      final initial = wallet.balance;
      wallet.deposit(50.0);
      expect(wallet.balance, initial + 50.0);
      expect(wallet.transactions.first.amount, 50.0);
      expect(wallet.transactions.first.type, 'Deposit');
    });

    test('withdraw decreases balance and adds transaction', () {
      final wallet = WalletController();
      final initial = wallet.balance;
      final ok = wallet.withdraw(30.0);
      expect(ok, isTrue);
      expect(wallet.balance, initial - 30.0);
      expect(wallet.transactions.first.amount, 30.0);
      expect(wallet.transactions.first.type, 'Withdrawal');
    });

    test('withdraw fails when insufficient funds', () {
      final wallet = WalletController();
      final ok = wallet.withdraw(9999999.0);
      expect(ok, isFalse);
    });
  });
}
