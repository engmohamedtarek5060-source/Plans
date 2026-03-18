import 'package:flutter/material.dart';

class AccountNode {
  final String code;
  final String name;
  final String nameEn;
  final double amount;
  final IconData icon;
  final Color iconColor;
  final String type;
  final List<AccountNode> children;
  final bool isLeaf;

  AccountNode({
    required this.code,
    required this.name,
    required this.nameEn,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.type,
    this.children = const [],
    this.isLeaf = false,
  });
}
