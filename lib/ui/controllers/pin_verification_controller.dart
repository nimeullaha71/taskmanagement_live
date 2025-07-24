import 'package:get/get.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';

class PinVerificationController extends GetxController{
  bool _otpInProgress = false;


  Future<bool> VerifyOTP(String email,String otp) async {

      _otpInProgress = true;
      update();

      NetworkResponse response = await NetworkClient.getRequest(
          url: Urls.OTPVerify(email, otp));

      _otpInProgress = false;
      update();
      if (response.isSuccess) {
        return true;
      } else {
        return false;
      }
  }
}