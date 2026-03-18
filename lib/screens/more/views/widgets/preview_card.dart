// ==================== preview_card.dart (محدث) ====================
import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final bool isEnglish;
  final String records;
  final String fileSize;
  final String format;
  final String period;

  const PreviewCard({
    super.key,
    required this.isEnglish,
    required this.records,
    required this.fileSize,
    required this.format,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Text(
            isEnglish ? 'Export Preview' : 'معاينة التصدير',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),

          // صف عدد السجلات
          _buildPreviewRow(
            label: isEnglish ? 'Records Count' : 'عدد السجلات',
            value: records,
            valueColor: Colors.orange,
          ),
          const SizedBox(height: 12),

          // صف حجم الملف
          _buildPreviewRow(
            label: isEnglish ? 'Expected File Size' : 'حجم الملف المتوقع',
            value: fileSize,
            valueColor: Colors.orange,
          ),
          const SizedBox(height: 12),

          // صف الصيغة
          _buildPreviewRow(
            label: isEnglish ? 'Format' : 'الصيغة',
            value: format,
            valueColor: Colors.orange,
          ),
          const SizedBox(height: 12),

          // صف الفترة
          _buildPreviewRow(
            label: isEnglish ? 'Period' : 'الفترة',
            value: period,
            valueColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      ],
    );
  }
}
