// lib/features/employee/domain/entities/employee_entity.dart
import 'package:intl/intl.dart';

class EmployeeEntity {
  final Name name;
  final String email;
  final String phone;
  final String gender;
  final DateTime dob;
  final DateTime registeredDate;
  final String pictureUrl;

  const EmployeeEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.registeredDate,
    required this.pictureUrl,
  });

  // Format: "26 Mar, 1999"
  String get formattedDob {
    return DateFormat('dd MMM, yyyy').format(dob);
  }

  // Format: "28 May, 2016"  
  String get formattedRegisteredDate {
    return DateFormat('dd MMM, yyyy').format(registeredDate);
  }

  // Returns "Female" or "Male" with proper casing
  String get formattedGender {
    return gender[0].toUpperCase() + gender.substring(1);
  }

  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }

  // For equality comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmployeeEntity &&
              runtimeType == other.runtimeType &&
              fullName == other.fullName &&
              email == other.email;

  @override
  int get hashCode => fullName.hashCode ^ email.hashCode;
}

// Name value object for better structure
class Name {
  final String title;
  final String first;
  final String last;

  const Name({
    required this.title,
    required this.first,
    required this.last,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Name &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              first == other.first &&
              last == other.last;

  @override
  int get hashCode => title.hashCode ^ first.hashCode ^ last.hashCode;
}