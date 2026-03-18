import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/inventory/views/widgets/inventory_main_content.dart';

class InventoryScreen extends StatefulWidget {
  final bool isEnglish;
  final String initialBranch;
  final int initialNotificationCount;

  const InventoryScreen({
    super.key,
    required this.isEnglish,
    this.initialBranch = 'الفرع الرئيسي',
    this.initialNotificationCount = 5,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedStatus = 'الكل';
  int _selectedFilter = 0;
  String _searchQuery = '';

  void _onStatusSelected(String status) =>
      setState(() => _selectedStatus = status);
  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: widget.isEnglish
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                widget.isEnglish ? 'Filter Options' : 'خيارات التصفية',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isEnglish ? 'Inventory' : 'المخزون',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.black),
                onPressed: () {},
              ),
              if (widget.initialNotificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      widget.initialNotificationCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: InventoryMainContent(
          isEnglish: widget.isEnglish,
          selectedStatus: _selectedStatus,
          selectedFilter: _selectedFilter,
          initialBranch: widget.initialBranch,
          initialNotificationCount: widget.initialNotificationCount,
          onStatusSelected: _onStatusSelected,
          onFilterTap: _onFilterTap,
          onSearchChanged: _onSearchChanged,
        ),
      ),
    );
  }
}
