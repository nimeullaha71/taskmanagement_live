import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class TaskcardController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;

  Future<bool> changeTaskStatus(String taskId,String status)async{
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(taskId,status));

    _inProgress = false;
    update();

    if(response.isSuccess){
      return true;
    }else{
      update();
      _errorMessage = response.errorMessage;
      return false;
    }
  }


  Future<bool> deleteTask(String taskId)async{
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.deleteTaskUrl(taskId));

    _inProgress = false;
    update();
    if(response.isSuccess){
      return true;

    }else{
      update();
      _errorMessage = response.errorMessage;
      return false;
    }
  }

}