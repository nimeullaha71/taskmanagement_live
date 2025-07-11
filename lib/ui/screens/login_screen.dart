import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanagement_live/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:taskmanagement_live/ui/screens/main_bottom_nav_screen.dart';
import 'package:taskmanagement_live/ui/screens/register_screen.dart';
import 'package:taskmanagement_live/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                      "Get Started With ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
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
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _onTapSignInButton,
                        child: Icon(Icons.arrow_circle_right_outlined)),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed: _onTapForgotPassword,
                              child: Text("Forgot Password ?")),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(text: "Don;t have an account ? "),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton,
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


  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (pre)=>false);
  }

  void _onTapForgotPassword() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ForgotPasswordVerifyEmailScreen()));
  }


  void _onTapSignUpButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

}
