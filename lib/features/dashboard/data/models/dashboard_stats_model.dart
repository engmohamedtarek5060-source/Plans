import 'package:saudiaaaa/core/utils/json_parse.dart';

/// GET /reports/dashboard
///
/// ```
/// {revenue:{thisMonth:num, thisYear:num}, outstanding:num, expenses:num,
///  counts:{customers:int, products:int, invoicesThisMonth:int, lowStock:int},
///  profit:num}
/// ```
/// Unlike the entity endpoints, these arrive as real JSON numbers — but they
/// still go through [asDouble] so a future Decimal change cannot crash us.
class DashboardKpisModel {
  const DashboardKpisModel({
    required this.revenueThisMonth,
    required this.revenueThisYear,
    required this.outstanding,
    required this.expenses,
    required this.profit,
    required this.customerCount,
    required this.productCount,
    required this.invoicesThisMonth,
    required this.lowStockCount,
  });

  final double revenueThisMonth;
  final double revenueThisYear;
  final double outstanding;
  final double expenses;
  final double profit;
  final int customerCount;
  final int productCount;
  final int invoicesThisMonth;
  final int lowStockCount;

  static DashboardKpisModel fromJson(Map<String, dynamic> json) {
    final revenue = asMap(json['revenue']);
    final counts = asMap(json['counts']);

    return DashboardKpisModel(
      revenueThisMonth: asDouble(revenue['thisMonth']),
      revenueThisYear: asDouble(revenue['thisYear']),
      outstanding: asDouble(json['outstanding']),
      expenses: asDouble(json['expenses']),
      profit: asDouble(json['profit']),
      customerCount: asInt(counts['customers']),
      productCount: asInt(counts['products']),
      invoicesThisMonth: asInt(counts['invoicesThisMonth']),
      lowStockCount: asInt(counts['lowStock']),
    );
  }
}

/// GET /reports/sales?fromDate&toDate
///
/// The useful part here is `byMonth: {"2026-07": 146.63}`, which is the only
/// real time series the backend exposes — it drives the dashboard chart.
class SalesReportModel {
  const SalesReportModel({required this.byMonth});

  /// Month key (`yyyy-MM`) -> total, ascending by month.
  final Map<String, double> byMonth;

  static SalesReportModel fromJson(Map<String, dynamic> json) {
    final raw = asMap(json['byMonth']);
    final entries = raw.entries
        .map((e) => MapEntry(e.key, asDouble(e.value)))
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return SalesReportModel(byMonth: Map.fromEntries(entries));
  }
}
