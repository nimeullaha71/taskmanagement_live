import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class AddNewTaskController extends GetxController{


  bool _addNewTaskInProgress = false;

  bool get addNewTaskInProgress => _addNewTaskInProgress;

  String ? _errorMessage;

  String ? get errorMessage => _errorMessage;


  Future<bool> addNewTask(String title,String description) async {

    _addNewTaskInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.createTaskUrl, body: requestBody);

    _addNewTaskInProgress = false;
    update();

    if(response.isSuccess){
      return true;
    }
    else{
      return false;
    }
  }
}