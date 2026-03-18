import 'package:flutter/material.dart';

class LoginTexts extends StatelessWidget {
  final bool isEnglish;

  const LoginTexts({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isEnglish ? 'Login' : 'تسجيل الدخول',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: isEnglish ? null : 'Tajawal',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isEnglish
              ? 'Enter your details to access your account'
              : 'أدخل بياناتك للوصول إلى حسابك',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontFamily: isEnglish ? null : 'Tajawal',
          ),
        ),
      ],
    );
  }
}
