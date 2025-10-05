part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
  @override
  List<Object?> get props => [];
}

class FetchEmployees extends EmployeeEvent {}

class LoadMoreEmployees extends EmployeeEvent {}
