import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/providers/locale_provider.dart';
import 'package:saudiaaaa/core/responsive/responsive_center.dart';
import 'package:saudiaaaa/core/theme/app_colors.dart';
import 'package:saudiaaaa/core/theme/app_effects.dart';
import 'package:saudiaaaa/core/theme/app_spacing.dart';
import 'package:saudiaaaa/core/utils/validators.dart';
import 'package:saudiaaaa/core/widgets/custom_primary_button.dart';
import 'package:saudiaaaa/core/widgets/custom_text_field.dart';
import 'package:saudiaaaa/core/widgets/glass_surface.dart';
import 'package:saudiaaaa/core/widgets/premium_background.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSending = false;
  bool _sent = false;
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: AppEffects.easeOut,
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_isSending) return;

    final isValid = _formKey.currentState?.validate() ?? false;
    if (kDebugMode) {
      debugPrint(
        'ForgotPasswordScreen validation: ${isValid ? 'passed' : 'failed'}',
      );
    }
    if (!isValid) return;

    if (kDebugMode) debugPrint('ForgotPasswordScreen submission started');
    setState(() => _isSending = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      setState(() {
        _isSending = false;
        _sent = true;
      });
      if (kDebugMode) {
        debugPrint('ForgotPasswordScreen submission completed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider.notifier).isArabic;
    final colors = context.appColors;

    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            // Scrollable so the fixed-height content never overflows in
            // landscape or on short screens; centered to a readable width.
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ResponsiveCenter(
                maxWidth: 480,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: colors.inputFill,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppEffects.glowShadow(
                          AppColors.brandPrimary,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      AppStrings.resetPassword(isArabic),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      AppStrings.resetPasswordHint(isArabic),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: GlassSurface(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (_sent) ...[
                              Container(
                                padding: AppSpacing.cardPadding,
                                decoration: BoxDecoration(
                                  color: colors.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.cardRadius,
                                  ),
                                  border: Border.all(
                                    color: colors.success.withValues(
                                      alpha: 0.25,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: colors.success,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        isArabic
                                            ? 'تم إرسال الرابط إلى بريدك الإلكتروني'
                                            : 'Reset link sent to your email',
                                        style: TextStyle(
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              CustomTextField(
                                controller: _emailController,
                                label: AppStrings.email(isArabic),
                                prefixIcon: Icons.alternate_email_rounded,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _sendReset(),
                                autofillHints: const [AutofillHints.email],
                                autocorrect: false,
                                enableSuggestions: false,
                                validator: (value) =>
                                    Validators.email(value, isArabic: isArabic),
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              CustomPrimaryButton(
                                label: AppStrings.sendResetLink(isArabic),
                                onPressed: _isSending ? null : _sendReset,
                                isLoading: _isSending,
                                icon: Icons.send_rounded,
                                useGradient: true,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // A scroll view has unbounded height, so a fixed gap
                    // replaces the former Spacer.
                    const SizedBox(height: AppSpacing.xxl),
                    CustomPrimaryButton(
                      label: AppStrings.backToLogin(isArabic),
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ButtonVariant.ghost,
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
  }
}
