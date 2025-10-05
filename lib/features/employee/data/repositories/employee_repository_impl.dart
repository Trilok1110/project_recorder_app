import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employee_repository.dart';
import '../data_sources/employee_remote_data_source.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<EmployeeEntity>> getEmployees({required int page}) async {
    try {
      final models = await remoteDataSource.fetchEmployees(page: page);
      return models;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}
