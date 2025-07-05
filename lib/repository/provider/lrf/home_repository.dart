import 'package:dio/dio.dart';
import 'package:task_demo/entities/dashboard_module/product_response.dart';
import 'package:task_demo/repository/model/search_param.dart';
import '../../../constant/import.dart';
import '../../contract_builder/app_repository_contract.dart';
import '../../data_source_manager/response_wrapper.dart';
import '../../data_source_manager/server_error.dart';
import '../../interceptor/app_interceptor.dart';
import '../../retrofit/api_client.dart';

class HomeRepository extends AppRepositoryContract {
  late Dio dio;
  late ApiClient _apiClient;

  HomeRepository() {
    dio = Dio();
    dio.interceptors.add(AppInterceptor());
    _apiClient = ApiClient(dio);
  }

  @override
  Future<ResponseWrapper<MDLProductResponse?, MDLMeta?>> searchProduct({
    required MDLProductSearchRequest param,
  }) async {
    var responseWrapper = ResponseWrapper<MDLProductResponse?, MDLMeta?>();
    try {
      var response = await _apiClient.searchProduct(param.toQueryMap());
      return responseWrapper..setData(response, null);
    } on DioError catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception {
      responseWrapper.setException(ServerError.withError(error: null));
    }

    return responseWrapper;
  }
}
