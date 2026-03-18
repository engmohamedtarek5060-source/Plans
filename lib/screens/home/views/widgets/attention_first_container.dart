import 'package:flutter/material.dart';
import 'package:saudiaaaa/screens/approvals/views/approvals_screen.dart';

class AttentionFirstContainer extends StatelessWidget {
  final bool isEnglish;

  const AttentionFirstContainer({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApprovalsScreen(
                isEnglish: isEnglish,
                // يمكنك إضافة المزيد من المعاملات إذا لزم الأمر
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.red[100]!, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // الدائرة الحمراء فوق البوردر
              Positioned(
                top: -12,
                left: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // المحتوى الرئيسي
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الأيقونة العلوية
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Icon(Icons.check, color: Colors.red, size: 18),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // النصوص
                    Text(
                      isEnglish ? 'Pending Approvals' : 'موافقات معلقة',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEnglish
                          ? 'Leave & Advance Requests'
                          : 'طلبات إجازة وسلف',
                      style: TextStyle(color: Colors.grey[700], fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
