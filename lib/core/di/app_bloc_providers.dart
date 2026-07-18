import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudiaaaa/core/di/app_dependencies.dart';
import 'package:saudiaaaa/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:saudiaaaa/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:saudiaaaa/features/auth/domain/repositories/auth_repository.dart';
import 'package:saudiaaaa/features/auth/domain/usecases/login_user.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';

/// Root-level BLoC providers for feature modules.
class AppBlocProviders extends StatelessWidget {
  const AppBlocProviders({
    super.key,
    required this.dependencies,
    required this.child,
  });

  final AppDependencies dependencies;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) {
            final AuthRepository repository = AuthRepositoryImpl(
              remote: AuthRemoteDataSource(dependencies.apiService),
              tokenStorage: dependencies.tokenStorage,
            );
            return AuthCubit(
              loginUser: LoginUser(repository),
              logoutUser: LogoutUser(repository),
              restoreSession: RestoreSession(repository),
              sessionEvents: dependencies.sessionEvents,
            )..bootstrap();
          },
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
