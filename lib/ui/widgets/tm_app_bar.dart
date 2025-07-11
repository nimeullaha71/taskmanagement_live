import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nime Ullaha",style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
                Text("nimeullaha@gmail.com",style: textTheme.bodySmall?.copyWith(color: Colors.white))
              ],
            ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.logout))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}