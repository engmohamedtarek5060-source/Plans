import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final bool isEnglish;
  final bool showPassword;
  final bool showConfirmPassword;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  const SignUpForm({
    super.key,
    required this.isEnglish,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
          context,
          controller: fullNameController,
          label: isEnglish ? 'Full Name' : 'الاسم الكامل',
          hintText: isEnglish ? 'Enter your full name' : 'أدخل اسمك الكامل',
          icon: Icons.person_outlined,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          context,
          controller: emailController,
          label: isEnglish ? 'Email' : 'البريد الإلكتروني',
          hintText: isEnglish ? 'example@email.com' : 'example@email.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          context,
          controller: phoneController,
          label: isEnglish ? 'Phone Number' : 'رقم الهاتف',
          hintText: isEnglish ? '05XXXXXXXX' : '05XXXXXXXX',
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        _buildPasswordInput(
          context,
          controller: passwordController,
          label: isEnglish ? 'Password' : 'كلمة المرور',
          hintText: isEnglish ? 'Enter your password' : 'أدخل كلمة المرور',
          showPassword: showPassword,
          onToggleVisibility: onTogglePassword,
        ),
        const SizedBox(height: 20),
        _buildPasswordInput(
          context,
          controller: confirmPasswordController,
          label: isEnglish ? 'Confirm Password' : 'تأكيد كلمة المرور',
          hintText: isEnglish ? 'Confirm your password' : 'أكد كلمة المرور',
          showPassword: showConfirmPassword,
          onToggleVisibility: onToggleConfirmPassword,
        ),
      ],
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 0,
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildPasswordInput(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: onToggleVisibility,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 0,
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
