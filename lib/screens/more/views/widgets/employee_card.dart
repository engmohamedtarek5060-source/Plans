import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/more/views/widgets/more_header.dart';

// ==================== Employee Card Widget ====================
class EmployeeCard extends StatelessWidget {
  final bool isEnglish;

  const EmployeeCard({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFFFF3E0), // لون برتقالي فاتح جداً
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: EmployeeInfo(isEnglish: isEnglish),
      ),
    );
  }
}

// ==================== Employee Info Widget ====================
class EmployeeInfo extends StatelessWidget {
  final bool isEnglish;

  const EmployeeInfo({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // معلومات الموظف (الاسم، المنصب، البريد)
        EmployeeDetails(isEnglish: isEnglish),
        const SizedBox(width: 16),
        // الصورة الرمزية
        const ProfileAvatar(),
      ],
    );
  }
}

// ==================== Employee Details Widget ====================
class EmployeeDetails extends StatelessWidget {
  final bool isEnglish;

  const EmployeeDetails({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isEnglish ? 'Ahmed Mohammed' : 'أحمد محمد',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isEnglish ? 'Sales Employee' : 'موظف مبيعات',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          'employee@demo.plans.sa',
          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

// ==================== Profile Avatar Widget ====================
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE65100), Color(0xFFFF9800)],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white, size: 32),
      ),
    );
  }
}
