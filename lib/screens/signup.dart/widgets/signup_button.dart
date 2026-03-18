import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/home/views/home_view.dart';

class SignUpButton extends StatelessWidget {
  final bool isEnglish;

  const SignUpButton({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          MaterialPageRoute(
            builder: (context) => HomeScreen(isEnglish: isEnglish),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE65100),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: const Color(0xFFE65100),
        ),
        child: Text(
          isEnglish ? 'Create Account' : 'إنشاء حساب',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
