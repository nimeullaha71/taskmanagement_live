import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement_live/ui/screens/login_screen.dart';
import 'package:taskmanagement_live/ui/utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void>_moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          SvgPicture.asset(
            width: double.maxFinite,
            height: double.maxFinite,
            AssetsPath.backgroundSvg,
            fit: BoxFit.cover,

          ),
          Center(child: SvgPicture.asset(AssetsPath.logoSvg,width: 120,),),

        ],
      ),
    );
  }
}
