import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/analtyics_container.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_vlue_container.dart';

class InventoryContainersRow extends StatelessWidget {
  final bool isEnglish;

  const InventoryContainersRow({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 180, // ارتفاع ثابت للتأكد من عدم التجاوز
            child: AnalyticsContainer(isEnglish: isEnglish),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 180, // ارتفاع ثابت للتأكد من عدم التجاوز
            child: InventoryValueContainer(isEnglish: isEnglish),
          ),
        ),
      ],
    );
  }
}
