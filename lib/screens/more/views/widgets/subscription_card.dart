// ==================== subscription_card.dart ====================
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final bool isEnglish;

  const SubscriptionCard({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // كلمة "اشتراك" فوق الكونتينر
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            isEnglish ? 'Subscription' : 'اشتراك',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // الكونتينر الرئيسي (أقل طولاً)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16), // تقليل الـ padding من 20 إلى 16
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // الصف العلوي: الدائرة الخضراء والنص والكونتينر
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // كونتينر "نشط" الصغير
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ), // تقليل الـ padding
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Text(
                        isEnglish ? 'Active' : 'نشط',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12, // تصغير الخط
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // تقليل المسافة
                    // نص "متقدم"
                    Text(
                      isEnglish ? 'Advanced' : 'متقدم',
                      style: const TextStyle(
                        fontSize: 16, // تصغير الخط
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8), // تقليل المسافة
                    // الدائرة الخضراء الفاتحة مع أيقونة التاج
                    Container(
                      width: 36, // تصغير الدائرة
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.green.shade700,
                          size: 18, // تصغير الأيقونة
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6), // تقليل المسافة
                // نص "ينتهي في 31/12/2024"
                Text(
                  isEnglish ? 'Expires on 31/12/2024' : 'ينتهي في ٣١/١٢/٢٠٢٤',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ), // تصغير الخط
                ),
                const SizedBox(height: 12), // تقليل المسافة
                // الصف الأيسر: 339 ويوم متبقي
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '339',
                          style: const TextStyle(
                            fontSize: 20, // تصغير الخط
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          isEnglish ? 'Days left' : 'يوم متبقي',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ), // تصغير الخط
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16), // تقليل المسافة
                // Divider
                Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
                const SizedBox(height: 16), // تقليل المسافة
                // الفواتير
                _buildStatItem(
                  label: isEnglish ? 'Invoices' : 'الفواتير',
                  currentValue: '247',
                  totalValue: '1,000',
                  progressValue: 0.247,
                  progressColor: Colors.green.shade400,
                ),
                const SizedBox(height: 16), // تقليل المسافة
                // المستخدمين
                _buildStatItem(
                  label: isEnglish ? 'Users' : 'المستخدمين',
                  currentValue: '8',
                  totalValue: '20',
                  progressValue: 0.4,
                  progressColor: Colors.green.shade400,
                ),
                const SizedBox(height: 16), // تقليل المسافة
                // المساحة
                _buildStatItem(
                  label: isEnglish ? 'Storage' : 'المساحة',
                  currentValue: '2.4',
                  totalValue: '50',
                  unit: 'GB',
                  progressValue: 0.048,
                  progressColor: Colors.green.shade400,
                ),
                const SizedBox(height: 16), // تقليل المسافة
                // كونتينر إدارة المشترك
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10), // تقليل الانحناء
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12, // تقليل الـ padding الرأسي
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.grey[600],
                              size: 20,
                            ), // تصغير الأيقونة
                            Text(
                              isEnglish
                                  ? 'Subscription Management'
                                  : 'إدارة المشترك',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14, // تصغير الخط
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String currentValue,
    required String totalValue,
    String unit = '',
    required double progressValue,
    required Color progressColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // التسمية (بحجم أصغر)
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]), // تصغير الخط
        ),
        const SizedBox(height: 4), // تقليل المسافة
        // القيمة
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              unit.isEmpty
                  ? '$currentValue / $totalValue'
                  : '$currentValue $unit / $totalValue $unit',
              style: const TextStyle(
                fontSize: 14, // تصغير الخط
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), // تقليل المسافة
        // شريط التحميل (أقل ارتفاعاً)
        Container(
          width: double.infinity,
          height: 6, // تقليل ارتفاع الشريط من 8 إلى 6
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progressValue.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
