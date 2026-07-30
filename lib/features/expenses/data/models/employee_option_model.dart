import 'package:saudiaaaa/core/utils/json_parse.dart';
import 'package:saudiaaaa/features/expenses/domain/entities/employee_option.dart';

/// `GET /hr/employees` -> bare JSON array.
///
/// Verified shape (trimmed to what the picker needs):
/// ```
/// {id:int, employeeNumber:"EMP-001", name:"Sara Ali", nameAr:"سارة علي",
///  department:String, jobTitle:String, isActive:bool, companyId:int, ...}
/// ```
class EmployeeOptionModel {
  const EmployeeOptionModel._();

  static EmployeeOption fromJson(Map<String, dynamic> json) {
    final name = asString(json['name']);
    return EmployeeOption(
      id: asInt(json['id']),
      // Fall back to the employee number so a row with no name is still
      // selectable rather than rendering as an empty line.
      name: name.isEmpty ? asString(json['employeeNumber']) : name,
      nameAr: asString(json['nameAr']),
    );
  }
}
