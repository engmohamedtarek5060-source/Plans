// ==================== supplier_details_screen.dart ====================
import 'package:flutter/material.dart';

class SupplierDetailsScreen extends StatelessWidget {
  final bool isEnglish;
  final String supplierName;
  final String category;
  final String phone;
  final String email;
  final String balance;
  final bool isActive;
  final String ordersCount;
  final String totalPurchases;

  const SupplierDetailsScreen({
    super.key,
    required this.isEnglish,
    required this.supplierName,
    required this.category,
    required this.phone,
    required this.email,
    required this.balance,
    required this.isActive,
    required this.ordersCount,
    required this.totalPurchases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // ========== App Bar ==========
            _buildAppBar(context),

            // ========== المحتوى الرئيسي ==========
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ===== بطاقة معلومات المورد =====
                    _buildSupplierInfoCard(),

                    const SizedBox(height: 16),

                    // ===== بطاقة المستحقات =====
                    _buildDuesCard(),

                    const SizedBox(height: 16),

                    // ===== كروت الإحصائيات =====
                    _buildStatsCards(),

                    const SizedBox(height: 16),

                    // ===== حالة الطلبات =====
                    _buildOrderStatus(),

                    const SizedBox(height: 16),

                    // ===== الأزرار =====
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== App Bar ==========
  Widget _buildAppBar(BuildContext context) {
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
          // سهم الرجوع
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              isEnglish ? Icons.arrow_back : Icons.arrow_forward,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
          // قائمة النقاط الثلاث
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.grey[700], size: 24),
          ),
        ],
      ),
    );
  }

  // ========== بطاقة معلومات المورد ==========
  Widget _buildSupplierInfoCard() {
    return Container(
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
          // الصف العلوي مع المربع البرتقالي
          Row(
            children: [
              // المربع البرتقالي
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),

              // اسم الشركة وحالة النشاط
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplierName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // كونتينر النشاط
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade700),
                      ),
                      child: Text(
                        isEnglish ? 'Active' : 'نشط',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.category, color: Colors.grey[400], size: 16),
              const SizedBox(width: 8),
              Text(
                category,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== بطاقة المستحقات ==========
  Widget _buildDuesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.shade50, Colors.white],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // الصف العلوي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // مربع الدولار الأبيض
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Icon(
                  Icons.attach_money,
                  color: Colors.red.shade600,
                  size: 24,
                ),
              ),

              // المستحقات الحالية
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isEnglish ? 'Current Dues' : 'المستحقات الحالية',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$balance ${isEnglish ? 'SAR' : 'ر.س'}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // مستحق للمورد
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isEnglish ? 'Due to supplier' : 'مستحق للمورد',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // استخدام الحد الائتماني
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '25%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              Text(
                isEnglish ? 'Credit Limit Usage' : 'استخدام الحد الائتماني',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // شريط التحميل
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.25,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade500),
              minHeight: 8,
            ),
          ),

          const SizedBox(height: 8),

          // الحد الائتماني
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isEnglish
                    ? 'Credit Limit: 10,000 SAR'
                    : 'الحد الائتماني: ١٠,٠٠٠ ر.س',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== كروت الإحصائيات ==========
  Widget _buildStatsCards() {
    return Row(
      children: [
        // كرت إجمالي الطلبات
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.list_alt,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ordersCount,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEnglish ? 'Total Orders' : 'إجمالي الطلبات',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // كرت إجمالي المشتريات
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$totalPurchases ${isEnglish ? 'K' : 'ألف'}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEnglish
                      ? 'Total Purchases (SAR)'
                      : 'إجمالي المشتريات (ر.س)',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ========== حالة الطلبات ==========
  Widget _buildOrderStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEnglish ? 'Order Status' : 'حالة الطلبات',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // مكتمل
              _buildStatusCircle(
                icon: Icons.check,
                iconColor: Colors.green,
                circleColor: Colors.green.shade100,
                value: '38',
                label: isEnglish ? 'Completed' : 'مكتمل',
                valueColor: Colors.green,
              ),

              // معلق
              _buildStatusCircle(
                icon: Icons.access_time,
                iconColor: Colors.orange,
                circleColor: Colors.orange.shade100,
                value: '5',
                label: isEnglish ? 'Pending' : 'معلق',
                valueColor: Colors.orange,
              ),

              // ملغي
              _buildStatusCircle(
                icon: Icons.close,
                iconColor: Colors.red,
                circleColor: Colors.red.shade100,
                value: '2',
                label: isEnglish ? 'Cancelled' : 'ملغي',
                valueColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ========== دائرة الحالة ==========
  Widget _buildStatusCircle({
    required IconData icon,
    required Color iconColor,
    required Color circleColor,
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  // ========== أزرار الإجراءات ==========
  Widget _buildActionButtons() {
    return Row(
      children: [
        // زر طلب شراء جديد
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.receipt, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  isEnglish ? 'New Purchase Order' : 'طلب شراء جديد',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // زر تعديل البيانات
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, color: Colors.grey[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  isEnglish ? 'Edit Data' : 'تعديل البيانات',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
