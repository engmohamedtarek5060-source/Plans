import 'package:flutter/material.dart';

class SignUpTexts extends StatelessWidget {
  final bool isEnglish;

  const SignUpTexts({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isEnglish ? 'Create Account' : 'إنشاء حساب',
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
              ? 'Enter your details to create a new account'
              : 'أدخل بياناتك لإنشاء حساب جديد',
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
