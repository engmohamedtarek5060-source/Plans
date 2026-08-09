import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/validators.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/presentation/auth_failure_message.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:saudiaaaa/features/auth/presentation/screens/register_screen.dart';
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
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: AppEffects.easeOut,
          ),
        );
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
    FocusManager.instance.primaryFocus?.unfocus();
    final cubit = context.read<AuthCubit>();
    if (cubit.isLoading) return;

    final isValid = _formKey.currentState?.validate() ?? false;
    if (kDebugMode) {
      debugPrint('LoginScreen validation: ${isValid ? 'passed' : 'failed'}');
    }
    if (!isValid) return;

    if (kDebugMode) debugPrint('LoginScreen submission started');
    await cubit.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (kDebugMode) debugPrint('LoginScreen submission completed');
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
                    content: Text(state.failure!.localized(isArabic)),
                    backgroundColor: colors.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.chipRadius,
                      ),
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          // Keep the form a comfortable reading width and
                          // centered on tablets instead of stretching fields
                          // edge to edge.
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: Form(
                                key: _formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        LoginLanguageToggle(isArabic: isArabic),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.xl),
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
                                      padding: const EdgeInsets.all(
                                        AppSpacing.lg,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          AutofillGroup(
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  controller: _emailController,
                                                  label: AppStrings.email(
                                                    isArabic,
                                                  ),
                                                  prefixIcon: Icons
                                                      .alternate_email_rounded,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  autofillHints: const [
                                                    AutofillHints.email,
                                                  ],
                                                  autocorrect: false,
                                                  enableSuggestions: false,
                                                  validator: (value) =>
                                                      Validators.email(
                                                        value,
                                                        isArabic: isArabic,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: AppSpacing.md,
                                                ),
                                                CustomPasswordField(
                                                  controller:
                                                      _passwordController,
                                                  label: AppStrings.password(
                                                    isArabic,
                                                  ),
                                                  prefixIcon: Icons
                                                      .lock_outline_rounded,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  onFieldSubmitted: (_) =>
                                                      _submit(),
                                                  autofillHints: const [
                                                    AutofillHints.password,
                                                  ],
                                                  validator: (value) =>
                                                      Validators.password(
                                                        value,
                                                        isArabic: isArabic,
                                                      ),
                                                ),
                                              ],
                                            ),
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
                                            onPressed: isLoading
                                                ? null
                                                : _submit,
                                            isLoading: isLoading,
                                            icon: Icons.arrow_forward_rounded,
                                            useGradient: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.xl),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.noAccount(isArabic),
                                          style: TextStyle(
                                            color: colors.textSecondary,
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: isLoading
                                              ? null
                                              : () => Navigator.of(context).push(
                                                  MaterialPageRoute<void>(
                                                    builder: (_) =>
                                                        const RegisterScreen(),
                                                  ),
                                                ),
                                          child: Text(
                                            AppStrings.signUp(isArabic),
                                          ),
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
