import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  final bool isEnglish;
  final bool isEmailSelected;
  final VoidCallback onEmailSelected;
  final VoidCallback onPhoneSelected;

  const LoginOptions({
    super.key,
    required this.isEnglish,
    required this.isEmailSelected,
    required this.onEmailSelected,
    required this.onPhoneSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.grey[300]!],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                isEnglish ? 'Login with your account' : 'تسجيل الدخول بحسابك',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[300]!, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onEmailSelected,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isEmailSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isEmailSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: isEmailSelected
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEnglish ? 'Email' : 'البريد الإلكتروني',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isEmailSelected
                                ? Colors.black
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onPhoneSelected,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: !isEmailSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: !isEmailSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_android_outlined,
                          color: !isEmailSelected
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEnglish ? 'Phone' : 'رقم الهاتف',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: !isEmailSelected
                                ? Colors.black
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
