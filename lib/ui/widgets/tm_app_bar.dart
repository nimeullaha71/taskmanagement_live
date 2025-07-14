import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void _onTapProfileSection(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
  }
  Future<void> _onTapLogOutButton(BuildContext context) async{
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()),(predicate)=>false);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
