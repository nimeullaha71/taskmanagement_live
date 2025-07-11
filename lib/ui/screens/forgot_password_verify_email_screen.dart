import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement_live/ui/screens/forgot_password_pin_verification_screen.dart';
import 'package:taskmanagement_live/ui/screens/register_screen.dart';

import '../widgets/screen_background.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {

  final TextEditingController _emailTEController = TextEditingController();
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
                      "Your Email Address ",
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
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: _onTapSubmitButton, child: Icon(Icons.arrow_circle_right_outlined)),
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordPinVerificationScreen()));
  }


  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();

  }

}