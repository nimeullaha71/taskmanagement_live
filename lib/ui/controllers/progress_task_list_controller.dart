import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class ProgressTaskListController extends GetxController{

  bool _getProgressTaskInProgress = false;

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  List<TaskModel> _progressTaskList = [];

  List<TaskModel> get progressTaskList => _progressTaskList;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;

  Future<bool> getAllProgressTaskList() async {
    _getProgressTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.progressTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _progressTaskList = taskListModel.taskList;
      _errorMessage = null;
      _getProgressTaskInProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _getProgressTaskInProgress = false;
      update();
      return false;
    }
  }
}