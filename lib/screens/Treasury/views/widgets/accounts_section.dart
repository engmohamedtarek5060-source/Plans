import 'package:flutter/material.dart';

class AccountsSection extends StatelessWidget {
  final bool isEnglish;

  const AccountsSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isEnglish ? 'Accounts' : 'الحسابات',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),

        AccountCard(
          balance: '45,250',
          name: 'الخزينة الرئيسية',
          iban: '',
          icon: Icons.wallet,
          bgColor: const Color(0xffFFF7E6),
          iconColor: const Color(0xffD28B00),
        ),
        const SizedBox(height: 12),

        AccountCard(
          balance: '285,400',
          name: 'البنك الأهلي',
          iban: 'SA12 3456 7890 1234 5678',
          icon: Icons.account_balance,
          bgColor: const Color(0xffEEF5FF),
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 12),

        AccountCard(
          balance: '156,780',
          name: 'بنك الراجحي',
          iban: 'SA98 7654 3210 9876 5432',
          icon: Icons.account_balance,
          bgColor: const Color(0xffEEF5FF),
          iconColor: Colors.blue,
        ),
      ],
    );
  }
}

class AccountCard extends StatelessWidget {
  final String balance;
  final String name;
  final String iban;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const AccountCard({
    super.key,
    required this.balance,
    required this.name,
    required this.iban,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (iban.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    iban,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balance,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffD28B00),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ر.س',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
