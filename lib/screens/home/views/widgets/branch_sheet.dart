// Branch Sheet Widget
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/branch_item.dart';

class BranchSheet extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final Function(String) onBranchSelected;

  BranchSheet({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.onBranchSelected,
  });

  final List<Map<String, dynamic>> branches = [
    {
      'name': 'الفرع الرئيسي',
      'englishName': 'Main Branch',
      'address': 'الرياض - حي العليا',
      'isActive': true,
    },
    {
      'name': 'فرع جدة',
      'englishName': 'Jeddah Branch',
      'address': 'جدة - حي الصفا',
      'isActive': false,
    },
    {
      'name': 'فرع الدمام',
      'englishName': 'Dammam Branch',
      'address': 'الدمام - حي النخيل',
      'isActive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'Choose Branch' : 'اختر فرع',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey[300], height: 1, thickness: 1),

          // Branches List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: branches.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final branch = branches[index];
                final isSelected = branch['name'] == selectedBranch;

                return BranchItem(
                  branch: branch,
                  isSelected: isSelected,
                  isEnglish: isEnglish,
                  onTap: () {
                    onBranchSelected(branch['name']);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
