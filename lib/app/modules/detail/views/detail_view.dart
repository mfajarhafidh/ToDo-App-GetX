import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app/app/core/utils/extensions.dart';
import 'package:todo_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:todo_app/app/modules/detail/widgets/doing_list.dart';
import 'package:todo_app/app/modules/detail/widgets/done_list.dart';
import 'package:todo_app/app/modules/home/controllers/home_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    var task = controller.task.value!;
    // var colorGet = controller.taskColor;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        controller.updateTodos();
                        controller.changeTask(null);
                        controller.editController.clear();
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  controller.doingTodos.length + controller.doneTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    Text(
                      '$totalTodos Tasks',
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: controller.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color]),
                        unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!]),
                      ),
                    )
                  ],
                ),
              );
            }),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                //Modified
                onFieldSubmitted: (value) {
                  if (controller.formKey.currentState!.validate()) {
                    var success =
                        controller.addTodo(controller.editController.text);
                    if (success) {
                      EasyLoading.showSuccess('Todo item add success');
                    } else {
                      EasyLoading.showError('Todo item already exist');
                    }
                    controller.editController.clear();
                  }
                },
                controller: controller.editController,
                autofocus: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          var success = controller
                              .addTodo(controller.editController.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo item add success');
                          } else {
                            EasyLoading.showError('Todo item already exist');
                          }
                          controller.editController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    )),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList()
          ],
        ),
      )),
    );
  }
}
