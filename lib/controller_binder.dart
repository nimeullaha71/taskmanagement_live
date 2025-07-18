import 'package:get/get.dart';
import 'package:taskmanagement_live/ui/controllers/login_controller.dart';
import 'package:taskmanagement_live/ui/controllers/new_task_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
  }

}