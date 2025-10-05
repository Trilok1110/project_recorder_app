import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.gender,
    required super.dob,
    required super.registeredDate,
    required super.pictureUrl,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: Name(
        title: json['name']['title'] ?? '',
        first: json['name']['first'] ?? '',
        last: json['name']['last'] ?? '',
      ),
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      dob: DateTime.parse(json['dob']['date'] ?? DateTime.now().toString()),
      registeredDate: DateTime.parse(json['registered']['date'] ?? DateTime.now().toString()),
      pictureUrl: json['picture']['medium'] ?? '', // Using medium size for balance
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'title': name.title,
        'first': name.first,
        'last': name.last,
      },
      'email': email,
      'phone': phone,
      'gender': gender,
      'dob': {
        'date': dob.toIso8601String(),
      },
      'registered': {
        'date': registeredDate.toIso8601String(),
      },
      'picture': {
        'medium': pictureUrl,
      },
    };
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      dob: dob,
      registeredDate: registeredDate,
      pictureUrl: pictureUrl,
    );
  }
}