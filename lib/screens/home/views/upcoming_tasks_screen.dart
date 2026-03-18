import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/widgets/task_card.dart';

class UpcomingTasksScreen extends StatefulWidget {
  final bool isEnglish;

  const UpcomingTasksScreen({super.key, required this.isEnglish});

  @override
  State<UpcomingTasksScreen> createState() => _UpcomingTasksScreenState();
}

class _UpcomingTasksScreenState extends State<UpcomingTasksScreen> {
  // متغيرات الحالة
  String _selectedFilter = 'الكل';
  String _selectedCategory = 'الكل';

  // قائمة الكاتيجوريز (الـ 6 كونتينرات)
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'الكل',
      'titleEn': 'All Tasks',
      'number': '8',
      'icon': Icons.list_alt,
    },
    {
      'title': 'الموافقات',
      'titleEn': 'Approvals',
      'number': '2',
      'icon': Icons.check_circle,
    },
    {
      'title': 'اجتماعات',
      'titleEn': 'Meetings',
      'number': '1',
      'icon': Icons.people,
    },
    {
      'title': 'مواعيد',
      'titleEn': 'Appointments',
      'number': '1',
      'icon': Icons.schedule,
    },
    {
      'title': 'متابعة',
      'titleEn': 'Follow-up',
      'number': '2',
      'icon': Icons.flag,
    },
    {
      'title': 'مراجعة',
      'titleEn': 'Review',
      'number': '2',
      'icon': Icons.error_outline,
    },
  ];

  // قائمة المهام (كاملة)
  final List<Map<String, dynamic>> _allTasks = [
    {
      'title': 'مراجعة طلب خصم العميل الذهبي',
      'isUrgent': true,
      'description':
          'طلب خصم 15% على فاتورة بقيمة 85,000 ريال من شركة الأفق للتجارة',
      'assignedTo': 'أنت',
      'dueDate': '14 فبراير، 2020 م',
      'company': 'شركة الأفق للتجارة',
      'category': 'الموافقات',
    },
    {
      'title': 'اجتماع مع فريق المبيعات',
      'isUrgent': false,
      'description':
          'مراجعة أهداف الربع الأول والأداء الحالي مع التخطيط للربع الثاني',
      'assignedTo': 'أنت',
      'dueDate': '14 فبراير، ٢٠٢٠ م',
      'company': 'فريق المبيعات',
      'category': 'اجتماعات',
    },
    {
      'title': 'موعد مع عميل جديد',
      'isUrgent': false,
      'description': 'اجتماع تعريف بالمنتجات والخدمات',
      'assignedTo': 'أنت',
      'dueDate': '15 فبراير، 2020 م',
      'company': 'شركة الأمل',
      'category': 'مواعيد',
    },
    {
      'title': 'متابعة عرض سعر',
      'isUrgent': true,
      'description': 'متابعة عرض السعر المرسل لشركة البركة',
      'assignedTo': 'أنت',
      'dueDate': '13 فبراير، 2020 م',
      'company': 'شركة البركة',
      'category': 'متابعة',
    },
    {
      'title': 'مراجعة تقرير المبيعات',
      'isUrgent': false,
      'description': 'مراجعة تقرير مبيعات الربع الأول',
      'assignedTo': 'أنت',
      'dueDate': '20 فبراير، 2020 م',
      'company': 'الإدارة',
      'category': 'مراجعة',
    },
  ];

  // ✅ دالة لحذف مهمة مكتملة
  void _removeCompletedTask(String taskTitle) {
    setState(() {
      _allTasks.removeWhere((task) => task['title'] == taskTitle);
    });
  }

  // دالة لجلب المهام حسب الفلتر والكاتيجوري
  List<Map<String, dynamic>> _getFilteredTasks() {
    return _allTasks.where((task) {
      bool categoryMatch =
          _selectedCategory == 'الكل' || task['category'] == _selectedCategory;

      bool filterMatch = true;
      if (_selectedFilter == 'اليوم') {
        filterMatch = task['dueDate'].contains('14');
      } else if (_selectedFilter == 'هذا الأسبوع') {
        filterMatch = true;
      }

      return categoryMatch && filterMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الأربع كونتينرات الإحصائية
            Row(
              children: [
                Expanded(
                  child: _buildStatContainer(
                    number: '8',
                    text: widget.isEnglish ? 'Total' : 'الإجمالي',
                    gradientColors: const [
                      Color(0xFFFF6B00),
                      Color(0xFFFF9800),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer(
                    number: '2',
                    text: widget.isEnglish ? 'Urgent' : 'عاجل',
                    gradientColors: const [
                      Color(0xFFFF5500),
                      Color(0xFFFF8800),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer(
                    number: '0',
                    text: widget.isEnglish ? 'Today' : 'اليوم',
                    gradientColors: const [
                      Color(0xFFFF8800),
                      Color(0xFFFFB84D),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer(
                    number: '2',
                    text: widget.isEnglish ? 'In Progress' : 'جاري',
                    gradientColors: const [
                      Color(0xFFFF4500),
                      Color(0xFFFF7F50),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 2. أزرار التصفية الثلاثة
            Row(
              children: [
                Expanded(
                  child: _buildFilterButton(
                    text: widget.isEnglish ? 'All' : 'الكل',
                    isActive: _selectedFilter == 'الكل',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'الكل';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterButton(
                    text: widget.isEnglish ? 'Today' : 'اليوم',
                    isActive: _selectedFilter == 'اليوم',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'اليوم';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterButton(
                    text: widget.isEnglish ? 'This Week' : 'هذا الأسبوع',
                    isActive: _selectedFilter == 'هذا الأسبوع',
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'هذا الأسبوع';
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 3. الـ 6 كونتينرات في ListView أفقي
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isActive = _selectedCategory == category['title'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['title'];
                      });
                    },
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.orange : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isActive ? Colors.orange : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  category['icon'],
                                  color: isActive
                                      ? Colors.white
                                      : Colors.orange,
                                  size: 20,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.isEnglish
                                      ? category['titleEn']
                                      : category['title'],
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // دائرة الرقم
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.white
                                    : Colors.orange.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  category['number'],
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.orange
                                        : Colors.orange.shade800,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 4. عنوان المهام المعلقة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.isEnglish ? 'Pending Tasks' : 'المهام المعلقة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_getFilteredTasks().length} ${widget.isEnglish ? 'tasks' : 'مهام'}',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 5. المهام المصفاة
            _getFilteredTasks().isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.isEnglish
                                ? 'No tasks found'
                                : 'لا توجد مهام',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _getFilteredTasks().length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return TaskCard(
                        isEnglish: widget.isEnglish,
                        task: _getFilteredTasks()[index],
                        onTaskCompleted: _removeCompletedTask, // ✅ تمرير الدالة
                      );
                    },
                  ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // شريط التطبيق العلوي
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B00), Color(0xFFFF9800)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.isEnglish ? 'Upcoming Tasks' : 'المهام القريبة',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 28),
          onPressed: () => _showAddTaskDialog(context),
        ),
      ],
      elevation: 0,
    );
  }

  // الكونتينرات الإحصائية
  Widget _buildStatContainer({
    required String number,
    required String text,
    required List<Color> gradientColors,
  }) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  // أزرار التصفية
  Widget _buildFilterButton({
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isActive ? Colors.orange : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.isEnglish ? 'Add New Task' : 'إضافة مهمة جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: widget.isEnglish ? 'Task title' : 'عنوان المهمة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: widget.isEnglish ? 'Task description' : 'وصف المهمة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(widget.isEnglish ? 'Cancel' : 'إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.isEnglish ? 'Task added!' : 'تمت إضافة المهمة!',
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text(
              widget.isEnglish ? 'Add' : 'إضافة',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
