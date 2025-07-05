import 'package:task_demo/cubit/dashboard_module/dashboard_cubit.dart';
import 'package:task_demo/route/pages.dart';
import 'package:task_demo/ui/dashboard/home_screen.dart';
import '../constant/import.dart';
import '../repository/contract_builder/app_repository_builder.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.homeScreen,
      page:
          () => HomeScreen(
            dashboardCubit: DashboardCubit(
              repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home,
              ),
            ),
          ),
    ),
  ];
}
