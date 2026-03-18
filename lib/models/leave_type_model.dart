import 'package:flutter/material.dart';

enum LeaveType { annual, sick, emergency }

class LeaveTypeModel {
  final LeaveType type;
  final String title;
  final String description;
  final String maxDays;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final bool requiresAttachment;

  LeaveTypeModel({
    required this.type,
    required this.title,
    required this.description,
    required this.maxDays,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.requiresAttachment = false,
  });

  static List<LeaveTypeModel> getLeaveTypes() {
    return [
      LeaveTypeModel(
        type: LeaveType.annual,
        title: 'إجازة سنوية',
        description: 'الحد الأقصى: 30 يوم',
        maxDays: '30',
        icon: Icons.star_border,
        iconColor: Colors.orange.shade700,
        backgroundColor: Colors.orange.shade50,
      ),
      LeaveTypeModel(
        type: LeaveType.sick,
        title: 'إجازة مرضية',
        description: 'الحد الأقصى: 15 يوم • يتطلب مرفق',
        maxDays: '15',
        icon: Icons.favorite_border,
        iconColor: Colors.red.shade700,
        backgroundColor: Colors.red.shade50,
        requiresAttachment: true,
      ),
      LeaveTypeModel(
        type: LeaveType.emergency,
        title: 'إجازة طارئة',
        description: 'الحد الأقصى: 5 يوم',
        maxDays: '5',
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange.shade700,
        backgroundColor: Colors.orange.shade50,
      ),
    ];
  }
}
