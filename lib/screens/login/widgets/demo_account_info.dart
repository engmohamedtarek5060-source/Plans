import 'package:flutter/material.dart';

class DemoAccountInfo extends StatelessWidget {
  final bool isEnglish;

  const DemoAccountInfo({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFBBDEFB), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 15),
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: isEnglish ? 'Email:' : 'البريد:',
            value: 'demo@plans.com',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.phone_android_outlined,
            label: isEnglish ? 'Phone:' : 'الهاتف:',
            value: '0512345678',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.lock_outlined,
            label: isEnglish ? 'Password:' : 'كلمة المرور:',
            value: 'password123',
          ),
          const SizedBox(height: 15),
          const Divider(color: Color(0xFFBBDEFB), thickness: 1, height: 1),
          const SizedBox(height: 15),
          _buildInfoRow(
            icon: Icons.business_outlined,
            label: isEnglish
                ? 'For testing with multiple companies:'
                : 'للتحربة مع عدة شركات:',
            value: 'multi@plans.com',
          ),
          const SizedBox(height: 15),
          const Divider(color: Color(0xFFBBDEFB), thickness: 1, height: 1),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                icon: Icons.person_outlined,
                label: isEnglish ? 'HR Employee:' : 'موظف الموارد البشرية:',
                value: 'employee@demo.plans.sa',
                valueColor: const Color(0xFFD32F2F),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: Icons.lock_outlined,
                label: isEnglish ? 'Password:' : 'كلمة المرور:',
                value: 'Demo@123',
                valueColor: const Color(0xFFD32F2F),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      isEnglish ? 'For testing use:' : 'للتحربة استخدم:',
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color valueColor = const Color(0xFF1976D2),
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1976D2), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Color(0xFF1976D2),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' $value',
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
