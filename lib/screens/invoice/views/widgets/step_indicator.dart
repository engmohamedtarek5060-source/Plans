import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final bool isEnglish;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(1, '1'),
        _buildDivider(1),
        _buildStepCircle(2, '2'),
        _buildDivider(2),
        _buildStepCircle(3, '3'),
      ],
    );
  }

  Widget _buildStepCircle(int step, String number) {
    bool isActive = step <= currentStep;
    bool isCurrent = step == currentStep;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.orange : Colors.grey[300],
        border: isCurrent ? Border.all(color: Colors.orange, width: 2) : null,
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(int fromStep) {
    bool isActive = fromStep < currentStep;

    return Container(
      width: 40,
      height: 2,
      color: isActive ? Colors.orange : Colors.grey[300],
    );
  }
}
