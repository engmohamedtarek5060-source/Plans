import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/validators.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';
import 'package:saudiaaaa/features/auth/presentation/auth_failure_message.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:saudiaaaa/features/auth/presentation/cubit/auth_state.dart';

/// Creates a company and its first user.
///
/// Reached only from the company role. `/auth/register` requires a
/// `companyName` and rejects a `role` field outright, so registering always
/// provisions a company — there is no client-side signup to offer.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AuthCubit>().register(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          companyName: _companyController.text,
        );
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
                next is AuthAuthenticated ||
                (next is AuthUnauthenticated && next.failure != null),
            listener: (context, state) {
              // Registering signs the user in, and the root gate has already
              // swapped to the home shell underneath. Pop so this pushed route
              // stops covering it.
              if (state is AuthAuthenticated) {
                Navigator.of(context).pop();
                return;
              }
              if (state is AuthUnauthenticated && state.failure != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure!.localized(isArabic)),
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

              return SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Center(
                  // Keep the form a comfortable reading width on tablets
                  // instead of stretching fields edge to edge.
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_rounded),
                              // Blocked mid-flight: leaving now would orphan a
                              // request whose result the user still needs.
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            AppStrings.registerTitle(isArabic),
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            AppStrings.registerSubtitle(isArabic),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          GlassSurface(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextField(
                                  controller: _nameController,
                                  label: AppStrings.fullName(isArabic),
                                  hint: isArabic ? 'محمد أحمد' : 'Jane Doe',
                                  prefixIcon: Icons.person_outline_rounded,
                                  keyboardType: TextInputType.name,
                                  validator: (value) => Validators.requiredText(
                                    value,
                                    message: AppStrings.nameRequired(isArabic),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                CustomTextField(
                                  controller: _companyController,
                                  label: AppStrings.companyName(isArabic),
                                  hint: isArabic
                                      ? 'شركة الخطط التجارية'
                                      : 'Acme Trading Co',
                                  prefixIcon: Icons.business_outlined,
                                  validator: (value) => Validators.requiredText(
                                    value,
                                    message:
                                        AppStrings.companyNameRequired(isArabic),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                CustomTextField(
                                  controller: _emailController,
                                  label: AppStrings.email(isArabic),
                                  hint: 'name@company.com',
                                  prefixIcon: Icons.alternate_email_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => Validators.email(
                                    value,
                                    isArabic: isArabic,
                                  ),
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
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    ),
                                  ),
                                  validator: (value) => Validators.newPassword(
                                    value,
                                    isArabic: isArabic,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                CustomTextField(
                                  controller: _confirmController,
                                  label: AppStrings.confirmPassword(isArabic),
                                  hint: '••••••••',
                                  prefixIcon: Icons.lock_reset_rounded,
                                  obscureText: _obscureConfirm,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirm
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                      color: colors.textTertiary,
                                    ),
                                    onPressed: () => setState(
                                      () => _obscureConfirm = !_obscureConfirm,
                                    ),
                                  ),
                                  validator: (value) =>
                                      Validators.confirmPassword(
                                    value,
                                    original: _passwordController.text,
                                    isArabic: isArabic,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                CustomPrimaryButton(
                                  label: AppStrings.createAccount(isArabic),
                                  onPressed: isLoading ? null : _submit,
                                  isLoading: isLoading,
                                  icon: Icons.arrow_forward_rounded,
                                  useGradient: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.haveAccount(isArabic),
                                style: TextStyle(
                                  color: colors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.of(context).pop(),
                                child: Text(AppStrings.signIn(isArabic)),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
