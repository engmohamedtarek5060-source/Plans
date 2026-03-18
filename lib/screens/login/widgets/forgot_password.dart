import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/login/views/forgot_password_screen.dart';

class ForgotPassword extends StatelessWidget {
  final bool isEnglish;

  const ForgotPassword({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(isEnglish: isEnglish),
          ),
        );
      },
      child: Text(
        isEnglish ? 'Forgot Password?' : 'هل نسيت كلمة المرور؟',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
