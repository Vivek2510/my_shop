part of "dashboard_cubit.dart";

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardSuccessState extends DashboardState {}

class DashboardErrorState extends DashboardState {
  String errorMessage;

  DashboardErrorState(this.errorMessage);
}
