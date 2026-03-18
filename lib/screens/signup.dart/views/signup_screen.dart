import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/login/widgets/language_selector.dart';
import 'package:saudiaaaa/screens/login/widgets/logo_widget.dart';
import 'package:saudiaaaa/screens/signup.dart/widgets/login_link.dart';
import 'package:saudiaaaa/screens/signup.dart/widgets/signup_button.dart';
import 'package:saudiaaaa/screens/signup.dart/widgets/signup_form.dart';
import 'package:saudiaaaa/screens/signup.dart/widgets/signup_texts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isEnglish = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: SingleChildScrollView(
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
                SignUpTexts(isEnglish: _isEnglish),
                const SizedBox(height: 40),
                SignUpForm(
                  isEnglish: _isEnglish,
                  showPassword: _showPassword,
                  showConfirmPassword: _showConfirmPassword,
                  fullNameController: _fullNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  onTogglePassword: _togglePasswordVisibility,
                  onToggleConfirmPassword: _toggleConfirmPasswordVisibility,
                ),
                const SizedBox(height: 30),
                SignUpButton(isEnglish: _isEnglish),
                const SizedBox(height: 20),
                LoginLink(isEnglish: _isEnglish),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
