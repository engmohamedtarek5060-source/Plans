import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/login/views/login_screen.dart';

class LoginLink extends StatelessWidget {
  final bool isEnglish;

  const LoginLink({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isEnglish ? 'Already have an account?' : 'لديك حساب بالفعل؟',
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text(
            isEnglish ? 'Login' : 'تسجيل الدخول',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE65100),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
