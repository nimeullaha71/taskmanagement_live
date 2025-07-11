import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title will be here",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            Text("Description Will be here"),
            Text("Date :07/11/2025"),
            Row(
              children: [
                Chip(label: Text("New",style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.blue,
                  side: BorderSide.none,
                ),
                const Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
    );
  }
}