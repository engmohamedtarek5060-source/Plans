import 'package:saudiaaaa/features/dashboard/domain/entities/activity_item.dart';

class DashboardStats {
  const DashboardStats({
    required this.revenue,
    required this.expenses,
    required this.balance,
    required this.outstanding,
    required this.customerCount,
    required this.productCount,
    required this.invoicesThisMonth,
    required this.lowStockCount,
    required this.recentActivities,
    required this.chartData,
    this.revenueTrend,
    this.expensesTrend,
    this.balanceTrend,
  });

  /// Revenue for the current month.
  final double revenue;
  final double expenses;

  /// Net profit, as reported by the backend.
  final double balance;

  /// Unpaid receivables.
  final double outstanding;

  final int customerCount;
  final int productCount;
  final int invoicesThisMonth;
  final int lowStockCount;

  /// Newest invoices, mapped into a feed. Empty when the tenant has none.
  final List<ActivityItem> recentActivities;

  /// Monthly sales totals for the chart. Empty when there is nothing to plot.
  final List<double> chartData;

  /// Period-over-period movement, as a fraction (0.12 == +12%).
  ///
  /// Null when the backend gives us no basis to compute it — the UI hides the
  /// trend rather than showing an invented number.
  final double? revenueTrend;
  final double? expensesTrend;
  final double? balanceTrend;

  /// True when the tenant has no data at all, so the screen can show an empty
  /// state instead of a wall of zeroes.
  bool get isEmpty =>
      revenue == 0 &&
      expenses == 0 &&
      balance == 0 &&
      outstanding == 0 &&
      customerCount == 0 &&
      productCount == 0 &&
      recentActivities.isEmpty;
}
