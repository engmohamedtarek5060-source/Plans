import 'package:saudiaaaa/core/network/api_config.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';
import 'package:saudiaaaa/core/network/api_service.dart';
import 'package:saudiaaaa/features/dashboard/data/models/dashboard_stats_model.dart';
import 'package:saudiaaaa/features/dashboard/domain/entities/activity_item.dart';
import 'package:saudiaaaa/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:saudiaaaa/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:saudiaaaa/features/sales/domain/entities/invoice.dart';
import 'package:saudiaaaa/features/sales/domain/repositories/sales_repository.dart';

/// Assembles the dashboard from three sources, because no single endpoint
/// carries everything the screen shows:
///  - /reports/dashboard          -> the KPI numbers
///  - /reports/sales?from&to      -> `byMonth`, the only real time series
///  - /sales/invoices             -> the recent-activity feed
class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl({
    required ApiService api,
    required SalesRepository salesRepository,
  })  : _api = api,
        _salesRepository = salesRepository;

  final ApiService _api;
  final SalesRepository _salesRepository;

  static const _activityLimit = 5;

  /// Months of history to plot.
  static const _chartMonths = 12;

  @override
  Future<DashboardStats> getDashboardStats() async {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month - (_chartMonths - 1), 1);
    final to = DateTime(now.year, now.month + 1, 0);

    // The KPIs are the only must-have; the chart and feed are enrichments, so
    // fetch them together but let each degrade on its own.
    final results = await Future.wait([
      _api.getObject(ApiEndpoints.dashboard),
      _fetchChartSeries(from: from, to: to),
      _fetchRecentActivity(),
    ]);

    final kpis = DashboardKpisModel.fromJson(results[0] as Map<String, dynamic>);
    final chartData = results[1] as List<double>;
    final activities = results[2] as List<ActivityItem>;

    return DashboardStats(
      revenue: kpis.revenueThisMonth,
      expenses: kpis.expenses,
      balance: kpis.profit,
      outstanding: kpis.outstanding,
      customerCount: kpis.customerCount,
      productCount: kpis.productCount,
      invoicesThisMonth: kpis.invoicesThisMonth,
      lowStockCount: kpis.lowStockCount,
      chartData: chartData,
      recentActivities: activities,
      // The backend reports no prior-period baseline, so there is nothing to
      // compute a trend from. Left null; the UI hides the trend chip.
      revenueTrend: null,
      expensesTrend: null,
      balanceTrend: null,
    );
  }

  /// Monthly sales totals, zero-filled so the chart keeps a steady month count
  /// even when a month had no sales.
  Future<List<double>> _fetchChartSeries({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final json = await _api.getObject(
        ApiEndpoints.salesReport,
        query: {
          'fromDate': _isoDate(from),
          'toDate': _isoDate(to),
        },
      );
      final report = SalesReportModel.fromJson(json);
      if (report.byMonth.isEmpty) return const [];

      return List<double>.generate(_chartMonths, (i) {
        final month = DateTime(from.year, from.month + i);
        return report.byMonth[_monthKey(month)] ?? 0;
      });
    } on ApiException {
      // A missing chart must not take the whole dashboard down.
      return const [];
    }
  }

  Future<List<ActivityItem>> _fetchRecentActivity() async {
    try {
      final invoices = await _salesRepository.getInvoices();
      return invoices
          .take(_activityLimit)
          .map(_toActivity)
          .toList(growable: false);
    } on ApiException {
      return const [];
    }
  }

  static ActivityItem _toActivity(Invoice invoice) => ActivityItem(
        id: invoice.id,
        title: invoice.id,
        titleAr: invoice.id,
        subtitle: invoice.customer,
        subtitleAr: invoice.customerAr,
        amount: invoice.amount,
        // Sales invoices are money in.
        isIncome: true,
        timestamp: invoice.date,
        iconName: 'receipt',
      );

  static String _isoDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  /// Matches the backend's `byMonth` keys, e.g. `2026-07`.
  static String _monthKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}';
}
