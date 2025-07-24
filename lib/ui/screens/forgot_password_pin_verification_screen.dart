import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanagement_live/ui/controllers/pin_verification_controller.dart';
import 'package:taskmanagement_live/ui/screens/reset_password_screen.dart';

import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordPinVerificationScreen extends StatefulWidget {
  final String email;
  const ForgotPasswordPinVerificationScreen({super.key, required this.email,});

  @override
  State<ForgotPasswordPinVerificationScreen> createState() => _ForgotPasswordPinVerificationScreenState();
}

class _ForgotPasswordPinVerificationScreenState extends State<ForgotPasswordPinVerificationScreen> {

  final TextEditingController _pinCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Pin Verification",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                    Text("A 6 digit Verification pin will send to your\n email address",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration:const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: _pinCodeTEController,
                     appContext: context,
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: _VerifyOTP, child: Text("Verify")),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(text: "Have account ? "),
                                  TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }


  Future<void> _VerifyOTP() async {
    if (_formKey.currentState!.validate()) {

      bool isSuccess = await Get.find<PinVerificationController>().VerifyOTP(widget.email, _pinCodeTEController.text);
      if (isSuccess) {
        Get.to(ResetPasswordScreen(email: widget.email, OTP: _pinCodeTEController.text));
        showSnackBarMessage(context, "Request success.");
      } else {
        showSnackBarMessage(context, "Request failed ! try again later", true);
      }
    }
  }


  @override
  void dispose() {
    _pinCodeTEController.dispose();
    super.dispose();
  }
}