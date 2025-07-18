import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/controller_binder.dart';
import 'package:taskmanagement_live/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          border: _getZeroBode(),
        enabledBorder: _getZeroBode(),
        errorBorder: _getZeroBode(),
      ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                )
            ),
          ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          //bodyLarge: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)
        )

      ),
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
  OutlineInputBorder _getZeroBode(){
    return OutlineInputBorder(
      borderSide: BorderSide.none
    );
  }
}
