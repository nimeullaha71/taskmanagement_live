import 'package:flutter/material.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.OTP});
  final String email;
  final String OTP;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Map<String, dynamic> formValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cPassword": ""
  };

  bool _resetPasswordInProgress = false;

  @override
  void initState() {
    callStoreData();
    super.initState();
  }

  callStoreData(){
    String ? otp = widget.OTP;
    String ? email = widget.email;
    inputOnChange("email",email );
    inputOnChange("OTP",otp);

  }

  inputOnChange(mapKey,textValue){
    formValues.update(mapKey, (value)=>textValue);
  }


  FormOnSubmit() async {
    if (formValues["password"]!.isEmpty) {
      showSnackBarMessage(context, "password Required", true);
    } else if (formValues["password"] != formValues["cPassword"]) {
      showSnackBarMessage(context, "Confirm password should be same!", true);
    } else {
      _resetPasswordInProgress = true;
      setState(() {});

      NetworkResponse response =
      await NetworkClient.postRequest(url: Urls.resetPasswordUrl,
        body: {
          "email": formValues["email"],
          "OTP": formValues["OTP"],
          "password": formValues["password"]
        },
      );

      setState(() => _resetPasswordInProgress = false);
      if (response.isSuccess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
                (route) => false);
        showSnackBarMessage(context, "Password reset success.");
      } else {
        showSnackBarMessage(context, "Request failed ! try again later", true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Minimum Length password 6 character  with\n latter and number combination",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (textValue){
                    inputOnChange("password", textValue);
                  },
                  decoration: InputDecoration(hintText: "password"),
                ),
                SizedBox(
                  height: 14,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (textValue){
                    inputOnChange("cPassword", textValue);
                  },
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                        visible: _resetPasswordInProgress == false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: FormOnSubmit, child: Text("Confirm")))),
                SizedBox(
                  height: 20,
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
                                TextSpan(text: "Have Account ?"),
                                TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold))
                              ]))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

// void _onTapRegistration(){
//   Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistratonScreen()));
// }
}
