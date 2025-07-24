import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class CompletedTaskLIstController extends GetxController{

  bool _getCompletedTaskInComplete = false;

  bool get getCompletedTaskInComplete => _getCompletedTaskInComplete;

  List<TaskModel> _completedTaskLiist = [];

  List<TaskModel> get completedTaskLiist => _completedTaskLiist;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;

  Future<bool> getAllCompletedTaskList() async {
    _getCompletedTaskInComplete = true;
    update();
    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.CompletedTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskLiist = taskListModel.taskList;
      _errorMessage = null;
      _getCompletedTaskInComplete = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _getCompletedTaskInComplete = false;
      update();
      return false;
    }
  }
}
