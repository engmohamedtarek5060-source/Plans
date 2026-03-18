import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/signup.dart/views/signup_screen.dart';

class SignUpLink extends StatelessWidget {
  final bool isEnglish;

  const SignUpLink({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isEnglish ? "Don't have an account?" : "ليس لديك حساب؟",
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: Text(
              isEnglish ? "Create Account" : "إنشاء حساب",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF8C00),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
