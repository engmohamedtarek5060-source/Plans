import 'package:flutter/material.dart';

class ApprovalsTabs extends StatelessWidget {
  final bool isEnglish;
  final Function(String)? onTabChanged;
  final String initialTab;

  const ApprovalsTabs({
    super.key,
    required this.isEnglish,
    this.onTabChanged,
    this.initialTab = 'Pending',
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {'titleEn': 'All', 'titleAr': 'الكل', 'count': 4, 'color': Colors.orange},
      {
        'titleEn': 'Pending',
        'titleAr': 'معلقة',
        'count': 2,
        'color': Colors.grey[300],
      },
      {
        'titleEn': 'Approved',
        'titleAr': 'موافق عليها',
        'count': 1,
        'color': Colors.grey[300],
      },
      {
        'titleEn': 'Rejected',
        'titleAr': 'مرفوضة',
        'count': 1,
        'color': Colors.grey[300],
      },
    ];

    final int initialIndex = tabs.indexWhere(
      (tab) => tab['titleEn'] == initialTab,
    );

    return _TabsList(
      isEnglish: isEnglish,
      tabs: tabs,
      initialIndex: initialIndex >= 0 ? initialIndex : 1,
      onTabChanged: onTabChanged,
    );
  }
}

class _TabsList extends StatefulWidget {
  final bool isEnglish;
  final List<Map<String, dynamic>> tabs;
  final int initialIndex;
  final Function(String)? onTabChanged;

  const _TabsList({
    required this.isEnglish,
    required this.tabs,
    required this.initialIndex,
    this.onTabChanged,
  });

  @override
  State<_TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<_TabsList> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          final tab = widget.tabs[index];
          final isActive = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              if (widget.onTabChanged != null) {
                widget.onTabChanged!(tab['titleEn']);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == widget.tabs.length - 1 ? 0 : 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? Colors.orange : Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive ? Colors.orange : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.yellow[100],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${tab['count']}',
                        style: TextStyle(
                          color: isActive ? Colors.orange : Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.isEnglish ? tab['titleEn'] : tab['titleAr'],
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
