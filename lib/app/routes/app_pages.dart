import 'package:get/get.dart';

import 'package:todo_app/app/modules/detail/bindings/detail_binding.dart';
import 'package:todo_app/app/modules/detail/views/detail_view.dart';
import 'package:todo_app/app/modules/home/bindings/home_binding.dart';
import 'package:todo_app/app/modules/home/views/home_view.dart';
import 'package:todo_app/app/modules/reports/bindings/reports_binding.dart';
import 'package:todo_app/app/modules/reports/views/reports_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
  ];
}
