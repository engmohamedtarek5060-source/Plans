// models/expense_enums.dart

import 'package:flutter/material.dart';

class Category {
  final String nameAr;
  final String nameEn;
  final IconData icon;

  const Category({
    required this.nameAr,
    required this.nameEn,
    required this.icon,
  });
}

class PaymentMethod {
  final String nameAr;
  final String nameEn;
  final IconData icon;

  const PaymentMethod({
    required this.nameAr,
    required this.nameEn,
    required this.icon,
  });
}

class ExpenseConstants {
  static const List<Category> categories = [
    Category(nameAr: 'إيجار', nameEn: 'Rent', icon: Icons.home),
    Category(
      nameAr: 'خدمات (كهرباء، ماء، إنترنت)',
      nameEn: 'Utilities',
      icon: Icons.electrical_services,
    ),
    Category(nameAr: 'رواتب ومكافئات', nameEn: 'Salaries', icon: Icons.people),
    Category(
      nameAr: 'لوازم ومستلزمات',
      nameEn: 'Supplies',
      icon: Icons.inventory,
    ),
    Category(
      nameAr: 'صيانة وإصلاحات',
      nameEn: 'Maintenance',
      icon: Icons.build,
    ),
    Category(
      nameAr: 'تسويق وإعلانات',
      nameEn: 'Marketing',
      icon: Icons.campaign,
    ),
    Category(
      nameAr: 'نقل ومواصلات',
      nameEn: 'Transportation',
      icon: Icons.local_shipping,
    ),
    Category(nameAr: 'أخرى', nameEn: 'Other', icon: Icons.more_horiz),
  ];

  static const List<PaymentMethod> paymentMethods = [
    PaymentMethod(nameAr: 'نقدي', nameEn: 'Cash', icon: Icons.money),
    PaymentMethod(
      nameAr: 'تحويل بنكي',
      nameEn: 'Bank Transfer',
      icon: Icons.account_balance,
    ),
    PaymentMethod(
      nameAr: 'بطاقة ائتمان',
      nameEn: 'Credit Card',
      icon: Icons.credit_card,
    ),
    PaymentMethod(nameAr: 'شيك', nameEn: 'Check', icon: Icons.receipt),
  ];
}
