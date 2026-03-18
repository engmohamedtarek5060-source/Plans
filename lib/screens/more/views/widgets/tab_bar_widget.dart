// ==================== tab_bar_widget.dart (المعدل بالكامل) ====================
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final bool isEnglish;
  final TabController tabController;
  final int selectedTabIndex;

  const TabBarWidget({
    super.key,
    required this.isEnglish,
    required this.tabController,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.grey[600],
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          // تبويب التصدير
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload,
                  size: 18,
                  color: selectedTabIndex == 0
                      ? Colors.orange
                      : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(isEnglish ? 'Export' : 'تصدير'),
              ],
            ),
          ),
          // تبويب الاستيراد
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                  size: 18,
                  color: selectedTabIndex == 1
                      ? Colors.orange
                      : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(isEnglish ? 'Import' : 'استيراد'),
              ],
            ),
          ),
          // تبويب السجل
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 18,
                  color: selectedTabIndex == 2
                      ? Colors.orange
                      : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(isEnglish ? 'History' : 'السجل'),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: selectedTabIndex == 2
                        ? Colors.orange
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '3',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
