// ==================== stats_cards.dart ====================
import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {
  final bool isEnglish;

  const StatsCards({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // كرت التصدير
        Expanded(
          child: _buildStatCard(
            label: isEnglish ? 'Export' : 'التصدير',
            value: '247',
            icon: Icons.upload,
            iconColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        // كرت الاستيراد
        Expanded(
          child: _buildStatCard(
            label: isEnglish ? 'Import' : 'الاستيراد',
            value: '89',
            icon: Icons.download,
            iconColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        // كرت النسخ
        Expanded(
          child: _buildStatCard(
            label: isEnglish ? 'Backups' : 'النسخ',
            value: '15',
            icon: Icons.storage,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade400.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Icon(icon, color: iconColor, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
