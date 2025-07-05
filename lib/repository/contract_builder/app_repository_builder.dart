import '../../constant/import.dart';
import '../provider/lrf/home_repository.dart';
import 'app_repository_contract.dart';

class AppRepositoryBuilder {
  static AppRepositoryContract repository(
      {RepositoryProviderType of = RepositoryProviderType.lrf}) {
    switch (of) {
      case RepositoryProviderType.lrf:
        return HomeRepository();
      default:
        return HomeRepository();
    }
  }
}
