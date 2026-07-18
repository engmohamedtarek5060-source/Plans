import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/domain/failures/auth_failure.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:saudiaaaa/features/auth/presentation/widgets/login_language_toggle.dart';
import 'package:saudiaaaa/features/auth/presentation/widgets/login_logo.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: AppEffects.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: AppEffects.easeOut,
    ));
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AuthCubit>().login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  String _failureMessage(AuthFailure failure, bool isArabic) {
    return switch (failure) {
      InvalidCredentialsFailure() => AppStrings.invalidCredentials(isArabic),
      // Carries a specific cause (offline, timeout, server error) — showing it
      // beats a generic "something went wrong".
      NetworkAuthFailure(:final localized) => localized(isArabic),
      SessionExpiredFailure() => AppStrings.sessionExpired(isArabic),
      UnexpectedAuthFailure() => AppStrings.errorTitle(isArabic),
    };
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (prev, next) =>
                next is AuthUnauthenticated && next.failure != null,
            listener: (context, state) {
              if (state is AuthUnauthenticated && state.failure != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_failureMessage(state.failure!, isArabic)),
                    backgroundColor: colors.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                    ),
                  ),
                );
                context.read<AuthCubit>().clearFailure();
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: IntrinsicHeight(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      LoginLanguageToggle(isArabic: isArabic),
                                    ],
                                  ),
                                  const Spacer(flex: 1),
                                  const Center(child: LoginLogo()),
                                  const SizedBox(height: AppSpacing.xl),
                                  Text(
                                    AppStrings.loginTitle(isArabic),
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    AppStrings.loginSubtitle(isArabic),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.xxl),
                                  GlassSurface(
                                    padding: const EdgeInsets.all(AppSpacing.lg),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomTextField(
                                          controller: _emailController,
                                          label: AppStrings.email(isArabic),
                                          hint: 'name@company.com',
                                          prefixIcon: Icons.alternate_email_rounded,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return isArabic
                                                  ? 'أدخل البريد الإلكتروني'
                                                  : 'Enter your email';
                                            }
                                            if (!value.contains('@')) {
                                              return isArabic
                                                  ? 'بريد إلكتروني غير صالح'
                                                  : 'Invalid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppSpacing.md),
                                        CustomTextField(
                                          controller: _passwordController,
                                          label: AppStrings.password(isArabic),
                                          hint: '••••••••',
                                          prefixIcon: Icons.lock_outline_rounded,
                                          obscureText: _obscurePassword,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              size: 20,
                                              color: colors.textTertiary,
                                            ),
                                            onPressed: () => setState(
                                              () => _obscurePassword =
                                                  !_obscurePassword,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return isArabic
                                                  ? 'أدخل كلمة المرور'
                                                  : 'Enter your password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppSpacing.sm),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).push(
                                              MaterialPageRoute<void>(
                                                builder: (_) =>
                                                    const ForgotPasswordScreen(),
                                              ),
                                            ),
                                            child: Text(
                                              AppStrings.forgotPassword(
                                                isArabic,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: AppSpacing.sm),
                                        CustomPrimaryButton(
                                          label: AppStrings.signIn(isArabic),
                                          onPressed: isLoading ? null : _submit,
                                          isLoading: isLoading,
                                          icon: Icons.arrow_forward_rounded,
                                          useGradient: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.noAccount(isArabic),
                                        style: TextStyle(
                                          color: colors.textSecondary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                isArabic
                                                    ? 'التسجيل قريباً'
                                                    : 'Sign up coming soon',
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        child: Text(AppStrings.signUp(isArabic)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
