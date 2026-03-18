import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isEnglish,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE65100),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.orange.withOpacity(0.5),
        ),
        child: Text(
          isEnglish ? 'Login' : 'تسجيل الدخول',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
