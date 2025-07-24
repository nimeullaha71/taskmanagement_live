
import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class ForgotPasswordController extends GetxController{

bool _emailInProgress= false;


  Future<bool> emailVerify(String email) async {
    _emailInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
        url: Urls.recoverEmail(email));

    _emailInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}