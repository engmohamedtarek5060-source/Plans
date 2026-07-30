/// An employee, reduced to what the Add Expense picker needs.
///
/// `POST /hr/expense-claims` requires an integer `employeeId`, so the form has
/// to offer a real choice from `GET /hr/employees` rather than let the user type
/// an id.
class EmployeeOption {
  const EmployeeOption({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  final int id;
  final String name;

  /// Employees genuinely carry an Arabic name; it can be blank.
  final String nameAr;

  /// The name to show, falling back to the English one so an Arabic UI never
  /// renders a blank row.
  String label(bool isArabic) =>
      isArabic && nameAr.trim().isNotEmpty ? nameAr : name;
}
