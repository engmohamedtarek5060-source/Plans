// widgets/dropdown_field.dart

import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/add_expense/views/widgets/required_label.dart';

class DropdownField<T> extends StatelessWidget {
  final String? selectedValue;
  final List<T> items;
  final String Function(T) getItemName;
  final bool isEnglish;
  final bool isOpen;
  final Function(bool) onToggle;
  final Function(T) onSelected;
  final String hintText;

  const DropdownField({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.getItemName,
    required this.isEnglish,
    required this.isOpen,
    required this.onToggle,
    required this.onSelected,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RequiredLabel(text: hintText),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => onToggle(!isOpen),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
                Text(
                  selectedValue ?? hintText,
                  style: TextStyle(
                    color: selectedValue != null
                        ? Colors.black87
                        : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isOpen) _buildDropdownList(),
      ],
    );
  }

  Widget _buildDropdownList() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.map((item) {
          final itemName = getItemName(item);
          return GestureDetector(
            onTap: () => onSelected(item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedValue == itemName
                            ? Colors.orange
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: selectedValue == itemName
                        ? Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                  Text(
                    itemName,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
