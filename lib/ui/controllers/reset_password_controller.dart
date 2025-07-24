import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class ResetPasswordController extends GetxController{

  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Map<String, dynamic> formValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cPassword": ""
  };

  void updateField(String key, String value) {
    formValues[key] = value;
  }

  Future<bool>FormOnSubmit() async {

      _resetPasswordInProgress = true;
      update();

      NetworkResponse response =
      await NetworkClient.postRequest(url: Urls.resetPasswordUrl,
        body: {
          "email": formValues["email"],
          "OTP": formValues["OTP"],
          "password": formValues["password"]
        },
      );

      _resetPasswordInProgress = false;
      update();
      if (response.isSuccess) {
        return true;
      } else {
        return false;
      }
    }
  }