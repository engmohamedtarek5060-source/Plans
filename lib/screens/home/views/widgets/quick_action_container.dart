import 'package:flutter/material.dart';

class QuickActionContainer extends StatelessWidget {
  final Color containerColor;
  final Color iconContainerColor;
  final IconData icon;
  final Color iconColor;
  final String mainText;
  final Color mainTextColor;
  final String subText;
  final String circleNumber;
  final bool isEnglish;

  const QuickActionContainer({
    super.key,
    required this.containerColor,
    required this.iconContainerColor,
    required this.icon,
    required this.iconColor,
    required this.mainText,
    required this.mainTextColor,
    required this.subText,
    required this.circleNumber,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, // تقليل الارتفاع
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5), // تقليل السماكة
        borderRadius: BorderRadius.circular(12), // تقليل الزوايا
        gradient: LinearGradient(
          colors: [containerColor, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // دائرة حمراء على البوردر في أعلى اليسار
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
                  circleNumber,
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
            padding: const EdgeInsets.all(12.0), // تقليل الـ padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الكونتينر الصغير بالأيقونة في أعلى اليمين
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconContainerColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: iconContainerColor, width: 1.5),
                    ),
                    child: Center(
                      child: Icon(icon, color: iconColor, size: 22),
                    ),
                  ),
                ),

                const Spacer(),

                // النصوص
                Text(
                  mainText,
                  style: TextStyle(
                    color: mainTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subText,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
