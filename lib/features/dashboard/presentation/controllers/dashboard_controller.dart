import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:saudiaaaa/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:saudiaaaa/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:saudiaaaa/features/dashboard/domain/usecases/get_dashboard_stats.dart';
import 'package:saudiaaaa/features/sales/presentation/controllers/sales_controller.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepositoryImpl(
    api: ref.watch(apiServiceProvider),
    // Reuses the sales repository so the activity feed and the sales screen
    // agree on how an invoice is read.
    salesRepository: ref.watch(salesRepositoryProvider),
  ),
);

final getDashboardStatsProvider = Provider<GetDashboardStats>(
  (ref) => GetDashboardStats(ref.watch(dashboardRepositoryProvider)),
);

final dashboardControllerProvider =
    AsyncNotifierProvider<DashboardController, DashboardStats>(
  DashboardController.new,
);

class DashboardController extends AsyncNotifier<DashboardStats> {
  @override
  Future<DashboardStats> build() {
    return ref.read(getDashboardStatsProvider)();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getDashboardStatsProvider)(),
    );
  }
}
