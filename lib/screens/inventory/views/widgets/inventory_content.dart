import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_conatiner_row.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_header.dart';

class InventoryContent extends StatelessWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const InventoryContent({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InventoryHeader(
              isEnglish: isEnglish,
              initialBranch: initialBranch,
              initialNotificationCount: initialNotificationCount,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 180,
              child: InventoryContainersRow(isEnglish: isEnglish),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
