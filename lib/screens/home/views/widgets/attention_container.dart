import 'package:flutter/material.dart';

class AttentionContainer extends StatelessWidget {
  final int number;
  final Color circleColor;
  final Widget iconWidget;
  final String mainText;
  final String subText;
  final bool isFirstRow;
  final bool isEnglish;

  const AttentionContainer({
    super.key,
    required this.number,
    required this.circleColor,
    required this.iconWidget,
    required this.mainText,
    required this.subText,
    required this.isFirstRow,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: isFirstRow
              ? [Colors.red[100]!, Colors.white]
              : [Colors.yellow[100]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // الدائرة فوق البوردر
          Positioned(
            top: -15,
            left: 12,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // المحتوى الرئيسي
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الأيقونة العلوية
                Align(alignment: Alignment.centerRight, child: iconWidget),

                const Spacer(),

                // النصوص
                Text(
                  mainText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subText,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
