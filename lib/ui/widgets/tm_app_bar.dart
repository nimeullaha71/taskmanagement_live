import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/ui/controllers/auth_controller.dart';
import 'package:taskmanagement_live/ui/screens/login_screen.dart';
import 'package:taskmanagement_live/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key, this.fromProfileScreen,
  });

  final bool ? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if(fromProfileScreen ?? false){
            return;
          }
          _onTapProfileSection(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: _shouldShowImage(AuthController.userModel?.photo)?
              MemoryImage(base64Decode(AuthController.userModel?.photo ?? '')):null
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel?.fulName ?? 'Unknown',
                      style:
                          textTheme.bodyLarge?.copyWith(color: Colors.white)),
                  Text(AuthController.userModel?.email ?? 'Unknown',
                      style: textTheme.bodySmall?.copyWith(color: Colors.white))
                ],
              ),
            ),
            IconButton(onPressed: ()=>_onTapLogOutButton(context), icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }


  bool _shouldShowImage(String ? photo){
    return photo !=null && photo.isNotEmpty;
  }

  void _onTapProfileSection(BuildContext context) {
    Get.to(()=>UpdateProfileScreen());
  }
  Future<void> _onTapLogOutButton(BuildContext context) async{
    await AuthController.clearUserData();
    Get.offAll(()=>LoginScreen());

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
