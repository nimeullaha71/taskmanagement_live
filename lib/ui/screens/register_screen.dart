import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanagement_live/ui/widgets/screen_background.dart';

import '../utils/assets_path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
            child: SingleChildScrollView(
              child: Padding(
                key: _formKey,
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
                        "Join With Us",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTEController,
                        decoration: InputDecoration(
                          hintText: "Email",

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _firstNameTEController,
                        decoration: InputDecoration(
                          hintText: "First Name",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _lastNameTEController,
                        decoration: InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: _mobileTEController,
                        decoration: InputDecoration(
                          hintText: "Mobile",
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
                          onPressed: _onTapSubmitButton, child: Icon(Icons.arrow_circle_right_outlined)),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: RichText(
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }



  void _onTapSubmitButton(){

  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }


}
