import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanagement_live/ui/screens/login_screen.dart';
import 'package:taskmanagement_live/ui/screens/register_screen.dart';

import '../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();
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
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                    Text("Set a new password minimum length of 6 letters.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _newPasswordTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "New Password",
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller: _confirmNewPasswordTEController,
                      decoration: InputDecoration(
                        hintText: "Confirm New Password",
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),


                    ElevatedButton(
                        onPressed: _onTapSubmitButton, child: Text("Confirm")),
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignInButton,
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

  void _onTapSubmitButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (pre)=>false);
  }


  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (pre)=>false);
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }

}