import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/wallet_controller.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({super.key});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard>
    with SingleTickerProviderStateMixin {
  bool _pulsing = false;

  Future<void> _showAmountDialog(BuildContext context, bool isDeposit) async {
    final controller = TextEditingController();
    final wallet = Provider.of<WalletController>(context, listen: false);
    final result = await showDialog<double?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isDeposit ? 'Déposer' : 'Retirer'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'Montant'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              Navigator.of(ctx).pop(value);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    // If the widget was disposed while the dialog was open, update state but avoid using BuildContext.
    if (!mounted) {
      if (result != null && result > 0) {
        if (isDeposit) {
          wallet.deposit(result);
        } else {
          wallet.withdraw(result);
        }
      }
      return;
    }

    if (result == null || result <= 0) return;

    if (isDeposit) {
      wallet.deposit(result);
      _animatePulse();
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(const SnackBar(content: Text('Dépôt effectué')));
    } else {
      final ok = wallet.withdraw(result);
      if (ok) _animatePulse();
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(content: Text(ok ? 'Retrait effectué' : 'Solde insuffisant')),
      );
    }
  }

  void _animatePulse() {
    setState(() => _pulsing = true);
    Future.delayed(const Duration(milliseconds: 450), () {
      if (mounted) setState(() => _pulsing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletController>(context);
    final color = Theme.of(context).colorScheme.primary;
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: _pulsing ? 1.02 : 1.0,
      child: Card(
        color: color.withAlpha((0.06 * 255).round()),
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Portefeuille',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Text(
                  '${wallet.balance.toStringAsFixed(2)} €',
                  key: ValueKey<double>(wallet.balance),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAmountDialog(context, true),
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text('Déposer'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showAmountDialog(context, false),
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('Retirer'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
