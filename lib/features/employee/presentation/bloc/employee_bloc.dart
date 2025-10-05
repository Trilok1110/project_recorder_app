import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_employees.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployees getEmployees;
  int currentPage = 1;
  bool isFetching = false;

  EmployeeBloc({required this.getEmployees}) : super(EmployeeInitial()) {
    on<FetchEmployees>(_onFetchEmployees);
    on<LoadMoreEmployees>(_onLoadMoreEmployees);
  }

  Future<void> _onFetchEmployees(FetchEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employees = await getEmployees(page: 1);
      currentPage = 1;
      emit(EmployeeLoaded(employees: employees));
    } catch (e) {
      emit(EmployeeError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreEmployees(LoadMoreEmployees event, Emitter<EmployeeState> emit) async {
    if (state is EmployeeLoaded && !isFetching) {
      isFetching = true;
      currentPage++;
      try {
        final moreEmployees = await getEmployees(page: currentPage);
        final currentEmployees = (state as EmployeeLoaded).employees;
        emit(EmployeeLoaded(employees: [...currentEmployees, ...moreEmployees]));
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
      isFetching = false;
    }
  }
}
