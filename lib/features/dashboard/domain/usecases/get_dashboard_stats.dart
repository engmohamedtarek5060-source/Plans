import 'package:saudiaaaa/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:saudiaaaa/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardStats {
  const GetDashboardStats(this._repository);

  final DashboardRepository _repository;

  Future<DashboardStats> call() => _repository.getDashboardStats();
}
