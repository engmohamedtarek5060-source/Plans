import 'package:flutter/material.dart';
import 'package:saudiaaaa/features/shell/presentation/screens/main_shell_screen.dart';

/// Landing screen for the Company Owner role.
///
/// The existing five-tab shell (dashboard, sales, inventory, treasury, more)
/// *is* the owner-facing experience, so this is a named seam rather than a new
/// screen — a placeholder here would have orphaned the entire ERP. When the
/// owner flow needs to diverge from the shared shell, change the body here and
/// nothing upstream has to move.
class CompanyDashboardScreen extends StatelessWidget {
  const CompanyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => const MainShellScreen();
}
