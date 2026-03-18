// screens/financial_reports/views/cash_flow_details_screen.dart
import 'package:flutter/material.dart';

class CashFlowDetailsScreen extends StatelessWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;

  const CashFlowDetailsScreen({
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
              isEnglish ? 'Cash Flows' : 'التدفقات النقدية',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              isEnglish ? 'Cash Flow Snapshot' : 'نظرة سريعة على التدفقات',
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
              // الكونتينر الرئيسي (صافي التدفق النقدي)
              _buildMainCashFlowContainer(),

              const SizedBox(height: 20),

              // كونتينر تدفق الرصيد
              _buildBalanceFlowContainer(),

              const SizedBox(height: 20),

              // كونتينر التدفقات الداخلة
              _buildInflowContainer(),

              const SizedBox(height: 20),

              // كونتينر التدفقات الخارجية
              _buildOutflowContainer(),

              const SizedBox(height: 20),

              // كونتينر الرؤى السريعة
              _buildQuickInsightsContainer(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // الكونتينر الرئيسي (صافي التدفق النقدي)
  Widget _buildMainCashFlowContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.analytics,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isEnglish ? 'Net Cash Flow' : 'صافي التدفق النقدي',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEnglish ? '+64,680' : '+٦٤٬٦٨٠',
                    style: const TextStyle(
                      fontSize: 32,
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
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              isEnglish
                  ? 'Increase in cash liquidity'
                  : 'زيادة في السيولة النقدية',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // كونتينر تدفق الرصيد
  Widget _buildBalanceFlowContainer() {
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
          Text(
            isEnglish ? 'Balance Flow' : 'تدفق الرصيد',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildBalanceRow(
            label: isEnglish ? 'Opening Balance:' : 'الرصيد الافتتاحي:',
            value: isEnglish ? '425,000 SAR' : '٤٢٥٬٠٠٠ ر.س',
            valueColor: Colors.black87,
          ),
          const SizedBox(height: 8),
          _buildBalanceRow(
            label: isEnglish ? 'Total Revenues:' : 'إجمالي الإيرادات:',
            value: isEnglish ? '+342,850 SAR' : '+٣٤٢٬٨٥٠ ر.س',
            valueColor: Colors.green,
          ),
          const SizedBox(height: 8),
          _buildBalanceRow(
            label: isEnglish ? 'Total Expenses:' : 'إجمالي المصروفات:',
            value: isEnglish ? '-278,170 SAR' : '-٢٧٨٬١٧٠ ر.س',
            valueColor: Colors.red,
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey[300], thickness: 1),
          const SizedBox(height: 8),
          _buildBalanceRow(
            label: isEnglish ? 'Closing Balance:' : 'الرصيد الختامي:',
            value: isEnglish ? '489,680 SAR' : '٤٨٩٬٦٨٠ ر.س',
            valueColor: Colors.blue,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow({
    required String label,
    required String value,
    required Color valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // كونتينر التدفقات الداخلة
  Widget _buildInflowContainer() {
    // القيم الرقمية للاستخدام الداخلي
    final inflowPercentages = [54, 37, 9];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.green,
                  size: 16,
                ),
              ),
              Text(
                isEnglish ? 'Inflows' : 'التدفقات الداخلة',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInflowItem(
            label: isEnglish ? 'Cash Sales' : 'مبيعات نقدية',
            value: isEnglish ? '182,400 SAR' : '١٨٢٬٤٠٠ ر.س',
            percentage: isEnglish ? '54%' : '٥٤%',
            numericPercentage: inflowPercentages[0],
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildInflowItem(
            label: isEnglish ? 'Customer Collections' : 'تحصيلات من العملاء',
            value: isEnglish ? '125,200 SAR' : '١٢٥٬٢٠٠ ر.س',
            percentage: isEnglish ? '37%' : '٣٧%',
            numericPercentage: inflowPercentages[1],
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildInflowItem(
            label: isEnglish ? 'Other Revenues' : 'إيرادات أخرى',
            value: isEnglish ? '32,250 SAR' : '٣٢٬٢٥٠ ر.س',
            percentage: isEnglish ? '9%' : '٩%',
            numericPercentage: inflowPercentages[2],
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInflowItem({
    required String label,
    required String value,
    required String percentage,
    required int numericPercentage,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              percentage,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: numericPercentage / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // كونتينر التدفقات الخارجية
  Widget _buildOutflowContainer() {
    // القيم الرقمية للاستخدام الداخلي
    final outflowPercentages = [52, 25, 16, 7];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_upward, color: Colors.red, size: 16),
              ),
              Text(
                isEnglish ? 'Outflows' : 'التدفقات الخارجية',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildOutflowItem(
            label: isEnglish ? 'Purchases & Inventory' : 'مشتريات ومخزون',
            percentage: isEnglish ? '52%' : '٥٢%',
            numericPercentage: outflowPercentages[0],
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _buildOutflowItem(
            label: isEnglish ? 'Operating Expenses' : 'مصروفات تشغيلية',
            percentage: isEnglish ? '25%' : '٢٥%',
            numericPercentage: outflowPercentages[1],
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildOutflowItem(
            label: isEnglish ? 'Salaries & Wages' : 'رواتب وأجور',
            percentage: isEnglish ? '16%' : '١٦%',
            numericPercentage: outflowPercentages[2],
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildOutflowItem(
            label: isEnglish ? 'Other Expenses' : 'مصروفات أخرى',
            percentage: isEnglish ? '7%' : '٧%',
            numericPercentage: outflowPercentages[3],
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildOutflowItem({
    required String label,
    required String percentage,
    required int numericPercentage,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: numericPercentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }

  // كونتينر الرؤى السريعة
  Widget _buildQuickInsightsContainer() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.blue,
                  size: 16,
                ),
              ),
              Text(
                isEnglish ? 'Quick Insights' : 'رؤى سريعة',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            text: isEnglish
                ? 'Cash sales represent 54% of total revenues'
                : 'المبيعات النقدية تمثل ٥٤% من إجمالي الإيرادات',
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            text: isEnglish
                ? 'Purchases & inventory represent 52% of total expenses'
                : 'المشتريات والمخزون تمثل ٥٢% من إجمالي المصروفات',
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            text: isEnglish
                ? 'Cash liquidity ratio: 123.3%'
                : 'نسبة السيولة النقدية: ١٢٣٫٣%',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({required String text, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, size: 6, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
