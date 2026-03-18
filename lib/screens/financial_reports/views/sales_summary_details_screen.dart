// screens/financial_reports/views/sales_summary_details_screen.dart
import 'package:flutter/material.dart';

class SalesSummaryDetailsScreen extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const SalesSummaryDetailsScreen({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(
              isEnglish ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isEnglish ? 'Sales Summary' : 'ملخص المبيعات',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              isEnglish ? 'Sales Summary Report' : 'تقرير ملخص المبيعات',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEnglish ? 'Jan 2024' : 'يناير 2024',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // الكونتينر الرئيسي (إجمالي المبيعات)
              _buildMainSalesContainer(),

              const SizedBox(height: 20),

              // الصف الأول: 3 كونتينرات
              Row(
                children: [
                  // كونتينر العملاء
                  Expanded(
                    child: _buildStatContainer(
                      value: isEnglish ? '89' : '٨٩',
                      label: isEnglish ? 'Customers' : 'العملاء',
                      icon: Icons.people,
                      circleColor: const Color(0xFFFFF9C4),
                      iconColor: Colors.orange,
                      percentage: isEnglish ? '+15.2%' : '+١٥٫٢%',
                      percentageColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // كونتينر متوسط الفاتورة
                  Expanded(
                    child: _buildStatContainer(
                      value: isEnglish ? '1,388' : '١٬٣٨٨',
                      label: isEnglish ? 'Avg. Invoice' : 'متوسط الفاتورة',
                      icon: Icons.attach_money,
                      circleColor: const Color(0xFFE3F2FD),
                      iconColor: Colors.blue,
                      subValue: isEnglish ? 'SAR' : 'ر.س',
                      showPercentage: false,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // كونتينر عدد الفواتير
                  Expanded(
                    child: _buildStatContainer(
                      value: isEnglish ? '247' : '٢٤٧',
                      label: isEnglish ? 'Invoices' : 'عدد الفواتير',
                      icon: Icons.shopping_cart,
                      circleColor: const Color(0xFFFFF9C4),
                      iconColor: Colors.orange,
                      percentage: isEnglish ? '+8.3%' : '+٨٫٣%',
                      percentageColor: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // كونتينر المنتجات الأكثر مبيعاً
              _buildTopProductsContainer(),

              const SizedBox(height: 20),

              // كونتينر الاتجاه اليومي
              _buildDailyTrendContainer(),

              const SizedBox(height: 20),

              // كونتينر الملخص
              _buildSummaryContainer(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // الكونتينر الرئيسي (إجمالي المبيعات)
  Widget _buildMainSalesContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF43A047), Color(0xFFA5D6A7)],
        ),
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isEnglish ? 'Total Sales' : 'إجمالي المبيعات',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEnglish ? '342,850' : '٣٤٢٬٨٥٠',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isEnglish ? 'SAR' : 'ر.س',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isEnglish ? '+12.5%' : '+١٢٫٥%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    isEnglish
                        ? 'Compared to previous month'
                        : 'مقارنة بالشهر السابق',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // كونتينر الإحصائيات (للعملاء، متوسط الفاتورة، عدد الفواتير)
  Widget _buildStatContainer({
    required String value,
    required String label,
    required IconData icon,
    required Color circleColor,
    required Color iconColor,
    String? subValue,
    String? percentage,
    Color? percentageColor,
    bool showPercentage = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // الدائرة مع الأيقونة
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 14),
          ),
          const SizedBox(height: 4),

          // القيمة
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (subValue != null)
            Text(
              subValue,
              style: TextStyle(fontSize: 8, color: Colors.grey[600]),
            ),

          // النص
          Text(
            label,
            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // النسبة المئوية
          if (showPercentage && percentage != null) ...[
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: percentageColor ?? Colors.green,
                  ),
                ),
                const SizedBox(width: 1),
                Icon(
                  Icons.trending_up,
                  color: percentageColor ?? Colors.green,
                  size: 10,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // كونتينر المنتجات الأكثر مبيعاً
  Widget _buildTopProductsContainer() {
    // قيم النسب المئوية (بالأرقام الإنجليزية للاستخدام الداخلي)
    final percentageValues = [35, 28, 22, 15];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isEnglish ? 'Top Selling Products' : 'المنتجات الأكثر مبيعاً',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildProductItem(
            productName: isEnglish ? 'Product A' : 'منتج أ',
            percentage: isEnglish ? '35%' : '٣٥%',
            numericValue: percentageValues[0],
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildProductItem(
            productName: isEnglish ? 'Product B' : 'منتج ب',
            percentage: isEnglish ? '28%' : '٢٨%',
            numericValue: percentageValues[1],
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          _buildProductItem(
            productName: isEnglish ? 'Product C' : 'منتج ج',
            percentage: isEnglish ? '22%' : '٢٢%',
            numericValue: percentageValues[2],
            color: Colors.green,
          ),
          const SizedBox(height: 8),
          _buildProductItem(
            productName: isEnglish ? 'Other Products' : 'منتجات أخرى',
            percentage: isEnglish ? '15%' : '١٥%',
            numericValue: percentageValues[3],
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem({
    required String productName,
    required String percentage,
    required int numericValue,
    required Color color,
  }) {
    return Row(
      children: [
        Text(
          percentage,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            value: numericValue / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            productName,
            style: const TextStyle(fontSize: 10, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // كونتينر الاتجاه اليومي
  Widget _buildDailyTrendContainer() {
    final daysArabic = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];

    final daysEnglish = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    final valuesArabic = [
      '١٢٬٥٠٠ ر.س',
      '١٥٬٨٠٠ ر.س',
      '١٨٬٢٠٠ ر.س',
      '١٦٬٥٠٠ ر.س',
      '١٤٬٢٠٠ ر.س',
      '٨٬٥٠٠ ر.س',
      '٩٬٨٠٠ ر.س',
    ];

    final valuesEnglish = [
      '12,500 SAR',
      '15,800 SAR',
      '18,200 SAR',
      '16,500 SAR',
      '14,200 SAR',
      '8,500 SAR',
      '9,800 SAR',
    ];

    final numericValues = [12500, 15800, 18200, 16500, 14200, 8500, 9800];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // عنوان الكونتينر
          Text(
            isEnglish ? 'Daily Trend' : 'الاتجاه اليومي',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // الأيام - كل يوم في سطر منفصل
          for (int i = 0; i < 7; i++) ...[
            // صف اليوم والقيمة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // اليوم على الشمال
                Text(
                  isEnglish ? daysEnglish[i] : daysArabic[i],
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                // القيمة على اليمين
                Text(
                  isEnglish ? valuesEnglish[i] : valuesArabic[i],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // الخط الملون تحت
            LinearProgressIndicator(
              value: numericValues[i] / 20000,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                i == 2 ? Colors.green : Colors.orange, // الثلاثاء أخضر
              ),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            if (i < 6) const SizedBox(height: 16), // مسافة بين الأيام
          ],
        ],
      ),
    );
  }

  // كونتينر الملخص
  Widget _buildSummaryContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            isEnglish ? 'Summary' : 'الملخص',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // أعلى يوم مبيعات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? 'Tue (18,200 SAR)' : 'الثلاثاء (١٨٬٢٠٠ ر.س)',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              Text(
                isEnglish ? 'Highest Day' : 'أعلى يوم',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 6),
          Divider(color: Colors.grey[200], thickness: 1),
          const SizedBox(height: 6),

          // متوسط المبيعات اليومية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '13,643 SAR' : '١٣٬٦٤٣ ر.س',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                isEnglish ? 'Average' : 'المتوسط',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 6),
          Divider(color: Colors.grey[200], thickness: 1),
          const SizedBox(height: 6),

          // عدد أيام العمل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? '7 days' : '٧ أيام',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                isEnglish ? 'Work days' : 'أيام العمل',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
