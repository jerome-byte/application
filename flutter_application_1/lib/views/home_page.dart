import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/wallet_controller.dart';
import '../widgets/wallet_card.dart';
import '../widgets/transaction_card.dart';
import 'transactions_page.dart';
import 'settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletController>(context);
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const WalletCard(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Dernières transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ...wallet.latestThree.map(
                  (t) => TransactionCard(transaction: t),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          const TransactionsPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
