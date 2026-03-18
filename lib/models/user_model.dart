class UserModel {
  final String id;
  final String employeeId;
  final String fullName;
  final String position;
  final String department;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.employeeId,
    required this.fullName,
    required this.position,
    required this.department,
    required this.email,
    required this.phone,
  });

  factory UserModel.hrEmployee() {
    return UserModel(
      id: '1',
      employeeId: 'EMP-001',
      fullName: 'أحمد محمد علي',
      position: 'مدير مبيعات',
      department: 'قسم المبيعات',
      email: 'employee@demo.plans.sa',
      phone: '0512345678',
    );
  }
}
