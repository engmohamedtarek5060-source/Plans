import 'package:flutter/material.dart';
import 'quick_overview_container.dart';

class QuickOverviewSection extends StatelessWidget {
  final bool isEnglish;

  const QuickOverviewSection({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with grid icon and title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leave empty on the left
              Container(),

              // Grid icon and title on the right
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.grid_view, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isEnglish ? 'Quick Overview' : 'رؤية سريعة',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // Main Container
        QuickOverviewContainer(isEnglish: isEnglish),
      ],
    );
  }
}
