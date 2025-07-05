import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_demo/entities/dashboard_module/product_response.dart';
import 'package:task_demo/repository/contract_builder/app_repository_contract.dart';
import 'package:task_demo/repository/model/search_param.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AppRepositoryContract repository;

  DashboardCubit({required this.repository}) : super(DashboardInitialState());

  MDLProductResponse? productResponse;

  void getProductsApiCall({MDLProductSearchRequest? param}) async {
    try {
      emit(DashboardLoadingState());
      var response = await repository.searchProduct(
        param: param ?? MDLProductSearchRequest(),
      );

      if (response.getData != null) {
        productResponse = response.getData;
        emit(DashboardSuccessState());
      } else {
        emit(
          DashboardErrorState(await response.getException?.errorMessage ?? ''),
        );
      }
    } on Exception catch (e) {
      emit(DashboardErrorState(e.toString()));
    }
  }
}
