import 'package:flutter/material.dart';

class InventorySearchFilterBar extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onFilterTap;
  final Function(String)? onSearchChanged;

  const InventorySearchFilterBar({
    super.key,
    required this.isEnglish,
    required this.onFilterTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // حاوية الفلتر
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 2,
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!, width: 1.2),
                ),
                child: const Center(
                  child: Icon(Icons.filter_alt, color: Colors.black, size: 24),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // حاوية البحث
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!, width: 1.2),
                ),
                child: Row(
                  children: [
                    // أيقونة البحث
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                    ),
                    // حقل البحث
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: isEnglish
                              ? 'Search in inventory...'
                              : 'بحث في المخزون...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        onChanged: onSearchChanged,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Filter Bottom Sheet Widget
class InventoryFilterBottomSheet extends StatefulWidget {
  final bool isEnglish;
  final int initialSelectedFilter;
  final Function(int) onApplyFilter;

  const InventoryFilterBottomSheet({
    super.key,
    required this.isEnglish,
    required this.initialSelectedFilter,
    required this.onApplyFilter,
  });

  @override
  State<InventoryFilterBottomSheet> createState() =>
      _InventoryFilterBottomSheetState();
}

class _InventoryFilterBottomSheetState
    extends State<InventoryFilterBottomSheet> {
  late int _currentSelected;

  final List<String> _arabicTexts = ['الكل', 'جيد', 'منخفض', 'حرج'];
  final List<String> _englishTexts = ['All', 'Good', 'Low', 'Critical'];

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.initialSelectedFilter;
  }

  void _onSelect(int index) {
    setState(() {
      _currentSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isEnglish ? 'Filter Inventory' : 'تصفية المخزون',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                widget.isEnglish ? 'Status' : 'الحالة',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final isSelected = _currentSelected == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => _onSelect(index),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.yellow[100] : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.isEnglish
                            ? _englishTexts[index]
                            : _arabicTexts[index],
                        style: TextStyle(
                          color: isSelected ? Colors.orange : Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => widget.onApplyFilter(_currentSelected),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.isEnglish ? 'Apply Filters' : 'تطبيق الفلاتر',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
