import '../../../../core/network/api_client.dart';
import '../../domain/entities/employee_entity.dart';
import '../models/employee_model.dart';

// Interface
abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeEntity>> fetchEmployees({required int page});
}

 //Implementation
class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final ApiClient apiClient;

  EmployeeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<EmployeeEntity>> fetchEmployees({required int page}) async {
    try {
      final response = await apiClient.dio.get(
        '',
        queryParameters: {
          'results': 20,
          'page': page,
        },
      );

      final results = response.data['results'] as List<dynamic>;
      return results.map((e) => EmployeeModel.fromJson(e).toEntity()).toList();
    } catch (e) {
      throw Exception('DataSource error: $e');
    }
  }
}
