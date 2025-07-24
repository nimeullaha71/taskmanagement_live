import 'package:get/get.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class CancelledTaskListController extends GetxController{

  bool _getCanceledTaskInCanceled = false;

  bool get getCanceledTaskInCanceled => _getCanceledTaskInCanceled;

  List<TaskModel> _canceledTaskList = [];

  List<TaskModel> get canceledTaskList => _canceledTaskList;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;


  Future<bool> getAllCancelledTaskList() async {
    bool isSuccess = false;
    _getCanceledTaskInCanceled = true;
    update();
    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.CanceledTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _canceledTaskList = taskListModel.taskList;
      _errorMessage = null;
      _getCanceledTaskInCanceled = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _getCanceledTaskInCanceled = false;
      update();
      return false;
    }
  }
}