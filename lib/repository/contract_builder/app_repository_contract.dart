import 'package:task_demo/entities/dashboard_module/product_response.dart';
import 'package:task_demo/repository/model/search_param.dart';

import '../../constant/import.dart';
import '../data_source_manager/response_wrapper.dart';

abstract class AppRepositoryContract {
  Future<ResponseWrapper<MDLProductResponse?, MDLMeta?>> searchProduct(
      {required MDLProductSearchRequest param}) async {
    return ResponseWrapper<MDLProductResponse?, MDLMeta?>()..setData(null, null);
  }
}
