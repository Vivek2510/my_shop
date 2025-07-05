import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_demo/entities/dashboard_module/product_response.dart';
import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/') //Production
abstract class ApiClient {
  factory ApiClient(Dio dio) {
    return _ApiClient(dio);
  }

  @GET(Apis.productSearch)
  Future<MDLProductResponse> searchProduct(
    @Queries() Map<String, dynamic> query,
  );

  // @MultiPart()
  // @POST(Apis.editProfile)
  // Future<BaseResponse> editProfile(@Queries() Map<String, dynamic> queries,
  //     @Part(value: 'profile_image') File file);
  //
  // @GET(Apis.cms + "/{endpoint}")
  // Future<BaseResponse> termsCondition(@Path("endpoint") endPoint);
  //
}
