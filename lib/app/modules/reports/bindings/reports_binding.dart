import 'package:get/get.dart';
import 'package:todo_app/app/data/providers/task/provider.dart';
import 'package:todo_app/app/data/services/storage/repository.dart';

import '../controllers/reports_controller.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsController>(
      () => ReportsController(
          taskRepository: TaskRepository(taskProvider: TaskProvider())),
    );
  }
}
