import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/home_view.dart';
import 'package:saudiaaaa/screens/login/widgets/forgot_password.dart';
import 'package:saudiaaaa/screens/login/widgets/language_selector.dart';
import 'package:saudiaaaa/screens/login/widgets/logo_widget.dart';
import 'package:saudiaaaa/screens/login/widgets/login_texts.dart';
import 'package:saudiaaaa/screens/login/widgets/demo_accounts_section.dart';
import 'package:saudiaaaa/screens/login/widgets/login_options.dart';
import 'package:saudiaaaa/screens/login/widgets/input_section.dart';
import 'package:saudiaaaa/screens/login/widgets/login_button.dart';
import 'package:saudiaaaa/screens/login/widgets/demo_account_info.dart';
import 'package:saudiaaaa/screens/login/widgets/signup_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isEmailSelected = true;
  bool _isEnglish = false;
  bool _showPassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _handleOwnerQuickLogin() {
    _emailController.text = 'demo@plans.com';
    _passwordController.text = 'password123';
  }

  void _handleHrQuickLogin() {
    _emailController.text = 'employee@demo.plans.sa';
    _passwordController.text = 'Demo@123';
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(isEnglish: _isEnglish),
      ),
    );
  }

  void _handleLogin() {
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        LanguageSelector(
                          isEnglish: _isEnglish,
                          onToggle: _toggleLanguage,
                        ),
                        const SizedBox(height: 40),
                        const LogoWidget(),
                        const SizedBox(height: 30),
                        LoginTexts(isEnglish: _isEnglish),
                        const SizedBox(height: 30),
                        DemoAccountsSection(
                          isEnglish: _isEnglish,
                          onOwnerQuickLogin: _handleOwnerQuickLogin,
                          onHrQuickLogin: _handleHrQuickLogin,
                        ),
                        const SizedBox(height: 40),
                        LoginOptions(
                          isEnglish: _isEnglish,
                          isEmailSelected: _isEmailSelected,
                          onEmailSelected: () =>
                              setState(() => _isEmailSelected = true),
                          onPhoneSelected: () =>
                              setState(() => _isEmailSelected = false),
                        ),
                        const SizedBox(height: 40),
                        InputSection(
                          isEnglish: _isEnglish,
                          isEmailSelected: _isEmailSelected,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          phoneController: _phoneController,
                          showPassword: _showPassword,
                          onTogglePassword: _togglePasswordVisibility,
                        ),
                        const SizedBox(height: 20),

                        // ✅ التغيير المهم هنا - استخدام ForgotPassword مش ForgotPasswordScreen
                        ForgotPassword(isEnglish: _isEnglish),

                        const SizedBox(height: 30),
                        LoginButton(
                          isEnglish: _isEnglish,
                          onPressed: _handleLogin,
                        ),
                        const SizedBox(height: 20),
                        DemoAccountInfo(isEnglish: _isEnglish),
                        const SizedBox(height: 40),
                        SignUpLink(isEnglish: _isEnglish),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
