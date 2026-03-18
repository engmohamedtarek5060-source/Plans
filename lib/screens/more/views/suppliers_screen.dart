// ==================== suppliers_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/home_view.dart';
import 'package:saudiaaaa/screens/home/views/widgets/bottom_navigation_bar.dart';
import 'package:saudiaaaa/screens/more/views/supplier_details_screen.dart'; // 👈 إضافة import

class SuppliersScreen extends StatefulWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const SuppliersScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  int _currentIndex = 4;

  void _onNavItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isEnglish: widget.isEnglish),
        ),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // ========== App Bar ==========
            _buildAppBar(),

            // ========== المحتوى الرئيسي ==========
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== الكروت الإحصائية الثلاثة =====
                    _buildStatsRow(),

                    const SizedBox(height: 24),

                    // ===== قائمة الموردين =====
                    _buildSupplierCard(
                      name: widget.isEnglish
                          ? 'United Supplies Co.'
                          : 'شركة التوريدات المتحدة',
                      category: widget.isEnglish ? 'Electronics' : 'إلكترونيات',
                      phone: '+966501234567',
                      email: 'info@united-supplies.com',
                      balance: '25,000',
                      isActive: true,
                      ordersCount: '45',
                      lastOrder: widget.isEnglish ? '3 days ago' : 'منذ 3 أيام',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierDetailsScreen(
                              isEnglish: widget.isEnglish,
                              supplierName: widget.isEnglish
                                  ? 'United Supplies Co.'
                                  : 'شركة التوريدات المتحدة',
                              category: widget.isEnglish
                                  ? 'Electronics'
                                  : 'إلكترونيات',
                              phone: '+966501234567',
                              email: 'info@united-supplies.com',
                              balance: '25,000',
                              isActive: true,
                              ordersCount: '45',
                              totalPurchases: '1,250,000',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildSupplierCard(
                      name: widget.isEnglish
                          ? 'Modern Furniture'
                          : 'الأثاث الحديث',
                      category: widget.isEnglish ? 'Furniture' : 'أثاث',
                      phone: '+966501234568',
                      email: 'info@modern-furniture.com',
                      balance: '12,500',
                      isActive: true,
                      ordersCount: '32',
                      lastOrder: widget.isEnglish ? '5 days ago' : 'منذ 5 أيام',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierDetailsScreen(
                              isEnglish: widget.isEnglish,
                              supplierName: widget.isEnglish
                                  ? 'Modern Furniture'
                                  : 'الأثاث الحديث',
                              category: widget.isEnglish ? 'Furniture' : 'أثاث',
                              phone: '+966501234568',
                              email: 'info@modern-furniture.com',
                              balance: '12,500',
                              isActive: true,
                              ordersCount: '32',
                              totalPurchases: '850,000',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildSupplierCard(
                      name: widget.isEnglish
                          ? 'Fresh Food Supplies'
                          : 'تموينات الغذاء الطازج',
                      category: widget.isEnglish ? 'Food' : 'مواد غذائية',
                      phone: '+966501234569',
                      email: 'info@freshfood.com',
                      balance: '8,750',
                      isActive: false,
                      ordersCount: '18',
                      lastOrder: widget.isEnglish
                          ? '10 days ago'
                          : 'منذ 10 أيام',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierDetailsScreen(
                              isEnglish: widget.isEnglish,
                              supplierName: widget.isEnglish
                                  ? 'Fresh Food Supplies'
                                  : 'تموينات الغذاء الطازج',
                              category: widget.isEnglish
                                  ? 'Food'
                                  : 'مواد غذائية',
                              phone: '+966501234569',
                              email: 'info@freshfood.com',
                              balance: '8,750',
                              isActive: false,
                              ordersCount: '18',
                              totalPurchases: '450,000',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    _buildSupplierCard(
                      name: widget.isEnglish
                          ? 'Technical Solutions'
                          : 'حلول تقنية',
                      category: widget.isEnglish ? 'Technology' : 'تقنية',
                      phone: '+966501234570',
                      email: 'info@techsol.com',
                      balance: '23,400',
                      isActive: true,
                      ordersCount: '67',
                      lastOrder: widget.isEnglish ? '1 day ago' : 'منذ يوم',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierDetailsScreen(
                              isEnglish: widget.isEnglish,
                              supplierName: widget.isEnglish
                                  ? 'Technical Solutions'
                                  : 'حلول تقنية',
                              category: widget.isEnglish
                                  ? 'Technology'
                                  : 'تقنية',
                              phone: '+966501234570',
                              email: 'info@techsol.com',
                              balance: '23,400',
                              isActive: true,
                              ordersCount: '67',
                              totalPurchases: '2,100,000',
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isEnglish: widget.isEnglish,
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  // ========== دالة بناء App Bar ==========
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // أيقونة الرجوع
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              widget.isEnglish ? Icons.arrow_back : Icons.arrow_forward,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
          // العنوان
          Text(
            widget.isEnglish ? 'Suppliers' : 'الموردون',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // أيقونة الإشعارات
          Stack(
            children: [
              // IconButton(
              //   onPressed: () {}, icon: ,
              //   // icon: Icon(
              //   //   Icons.notifications_outlined,
              //   //   color: Colors.grey[700],
              //   //   size: 24,
              //   // ),
              // ),
              if (widget.notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${widget.notificationCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== دالة بناء الكروت الإحصائية ==========
  Widget _buildStatsRow() {
    return Row(
      children: [
        // كرت إجمالي الموردين
        Expanded(
          child: _buildStatsCard(
            icon: Icons.local_shipping,
            iconColor: Colors.amber,
            label: widget.isEnglish ? 'Total' : 'إجمالي',
            value: '6',
            valueColor: Colors.black,
          ),
        ),
        const SizedBox(width: 12),

        // كرت الموردين النشطين
        Expanded(
          child: _buildStatsCard(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            label: widget.isEnglish ? 'Active' : 'نشط',
            value: '4',
            valueColor: Colors.black,
          ),
        ),
        const SizedBox(width: 12),

        // كرت الرصيد المستحق
        Expanded(
          child: _buildStatsCard(
            icon: Icons.attach_money,
            iconColor: Colors.red,
            label: widget.isEnglish ? 'Balance' : 'رصيد',
            value: '105,555',
            valueColor: Colors.red,
          ),
        ),
      ],
    );
  }

  // ========== دالة بناء الكرت الإحصائي الواحد ==========
  Widget _buildStatsCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // الأيقونة في الأعلى يمين
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 8),

          // النص (إجمالي / نشط / رصيد)
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          // القيمة الرقمية
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // ========== دالة بناء بطاقة المورد ==========
  Widget _buildSupplierCard({
    required String name,
    required String category,
    required String phone,
    required String email,
    required String balance,
    required bool isActive,
    required String ordersCount,
    required String lastOrder,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // الصف العلوي
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // دائرة الشحن الصفراء
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_shipping,
                    color: Colors.orange.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // اسم الشركة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // كونتينرات النشاط
                      Row(
                        children: [
                          // كونتينر نشط
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.green.shade50
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isActive
                                  ? (widget.isEnglish ? 'Active' : 'نشط')
                                  : (widget.isEnglish ? 'Inactive' : 'غير نشط'),
                              style: TextStyle(
                                color: isActive
                                    ? Colors.green.shade700
                                    : Colors.grey.shade600,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // كونتينر التصنيف
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // معلومات الاتصال
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey[400], size: 16),
                const SizedBox(width: 8),
                Text(
                  phone,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.email, color: Colors.grey[400], size: 16),
                const SizedBox(width: 8),
                Text(
                  email,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Divider
            Divider(color: Colors.grey.shade300, height: 1, thickness: 1),

            const SizedBox(height: 16),

            // الصف السفلي (الرصيد، الطلبات، آخر عملية)
            Row(
              children: [
                // الرصيد
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isEnglish ? 'Balance' : 'الرصيد',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$balance ${widget.isEnglish ? 'SAR' : 'ر.س'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

                // الطلبات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.isEnglish ? 'Orders' : 'طلبات',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ordersCount,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // آخر عملية
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.isEnglish ? 'Last Order' : 'آخر عملية',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lastOrder,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
