// widgets/date_field.dart

import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/required_label.dart';

class DateField extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final bool isEnglish;

  const DateField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.isEnglish,
  });

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RequiredLabel(text: isEnglish ? 'Date' : 'التاريخ'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.orange,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              _formatDate(selectedDate),
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
