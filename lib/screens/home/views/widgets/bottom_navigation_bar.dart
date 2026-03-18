import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final bool isEnglish;
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.isEnglish,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.grid_view,
                label: widget.isEnglish ? 'Home' : 'الرئيسية',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.shopping_cart,
                label: widget.isEnglish ? 'Sales' : 'المبيعات',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.inventory,
                label: widget.isEnglish ? 'Inventory' : 'المخزون',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.account_balance_wallet,
                label: widget.isEnglish ? 'Treasury' : 'الخزينة',
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.more_horiz,
                label: widget.isEnglish ? 'More' : 'المزيد',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isActive = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container with background circle for active item
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24,
              color: isActive ? Colors.orange : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.orange : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
