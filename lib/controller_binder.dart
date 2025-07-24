import 'package:get/get.dart';
import 'package:taskmanagement_live/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanagement_live/ui/controllers/cancelled_list_controller.dart';
import 'package:taskmanagement_live/ui/controllers/completed_task_list_controller.dart';
import 'package:taskmanagement_live/ui/controllers/forgot_password_controller.dart';
import 'package:taskmanagement_live/ui/controllers/login_controller.dart';
import 'package:taskmanagement_live/ui/controllers/new_task_controller.dart';
import 'package:taskmanagement_live/ui/controllers/pin_verification_controller.dart';
import 'package:taskmanagement_live/ui/controllers/progress_task_list_controller.dart';
import 'package:taskmanagement_live/ui/controllers/register_controller.dart';
import 'package:taskmanagement_live/ui/controllers/reset_password_controller.dart';
import 'package:taskmanagement_live/ui/controllers/task_card_controller.dart';
import 'package:taskmanagement_live/ui/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(RegisterController());
    Get.put(ForgotPasswordController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());
    Get.put(CancelledTaskListController());
    Get.put(CompletedTaskLIstController());
    Get.put(ProgressTaskListController());
    Get.put(UpdateProfileController());
    Get.put(AddNewTaskController());
    Get.put(TaskcardController());
  }

}