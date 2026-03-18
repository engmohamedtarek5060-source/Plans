// screens/upcoming_tasks/widgets/tasks_tabs_section.dart
import 'package:flutter/material.dart';

class TasksTabsSection extends StatefulWidget {
  final bool isEnglish;
  final Function(String) onTabSelected;
  final String selectedTab;

  const TasksTabsSection({
    super.key,
    required this.isEnglish,
    required this.onTabSelected,
    required this.selectedTab,
  });

  @override
  State<TasksTabsSection> createState() => _TasksTabsSectionState();
}

class _TasksTabsSectionState extends State<TasksTabsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // التلات كونتينرات (الكل، اليوم، هذا الأسبوع)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildTabContainer(
                text: widget.isEnglish ? 'All' : 'الكل',
                tabValue: 'all',
              ),
              const SizedBox(width: 12),
              _buildTabContainer(
                text: widget.isEnglish ? 'Today' : 'اليوم',
                tabValue: 'today',
              ),
              const SizedBox(width: 12),
              _buildTabContainer(
                text: widget.isEnglish ? 'This Week' : 'هذا الأسبوع',
                tabValue: 'week',
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // الـ 6 كونتينرات
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // الصف الأول
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.list_alt,
                      text: widget.isEnglish ? 'All' : 'الكل',
                      number: '8',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.check_circle_outline,
                      text: widget.isEnglish ? 'Approvals' : 'الموافقات',
                      number: '2',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.people_outline,
                      text: widget.isEnglish ? 'Meetings' : 'اجتماعات',
                      number: '1',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // الصف الثاني
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.access_time,
                      text: widget.isEnglish ? 'Appointments' : 'مواعيد',
                      number: '1',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.flag_outlined,
                      text: widget.isEnglish ? 'Follow-ups' : 'متابعة',
                      number: '2',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryContainer(
                      icon: Icons.error_outline,
                      text: widget.isEnglish ? 'Reviews' : 'مراجعة',
                      number: '2',
                      backgroundColor: Colors.orange.shade50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // دالة لبناء كونتينر التبويب (الكل، اليوم، هذا الأسبوع)
  Widget _buildTabContainer({required String text, required String tabValue}) {
    final isSelected = widget.selectedTab == tabValue;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTabSelected(tabValue),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.grey[100],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.grey[300]!,
              width: 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة لبناء كونتينر التصنيف (الـ 6 كونتينرات)
  Widget _buildCategoryContainer({
    required IconData icon,
    required String text,
    required String number,
    required Color backgroundColor,
  }) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // المحتوى الرئيسي
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الأيقونة
                Icon(icon, color: Colors.orange, size: 20),
                const SizedBox(height: 4),
                // النص
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // الدائرة الصفراء مع الرقم
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 1.5),
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
