import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement_live/data/models/task_model.dart';
import 'package:taskmanagement_live/data/service/network_client.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:taskmanagement_live/ui/widgets/snack_bar_message.dart';

enum TaskStatus{
  sNew,
  progress,
  completed,
  cancel,
}

class Taskcard extends StatefulWidget {
  const Taskcard({
    super.key, required this.taskStatus, required this.taskModel, required this.refreshList,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {

  bool _inProgress = false;

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
            Text(widget.taskModel.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            Text(widget.taskModel.description),
            //Text(taskModel.createdDate),
            Text(formatDate(DateTime.parse(widget.taskModel.createdDate),[yyyy, '-', mm, '-', dd])),
            Row(
              children: [
                Chip(label: Text(widget.taskModel.status,style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                Visibility(
                  visible: _inProgress==false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                      IconButton(onPressed: _showUpdateStatusDialog, icon: Icon(Icons.edit)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor(){
    if(widget.taskStatus==TaskStatus.sNew){
      return Colors.blue;
    }
    else if(widget.taskStatus==TaskStatus.progress){
      return Colors.purple;
    }
    else if(widget.taskStatus==TaskStatus.completed){
      return Colors.green;
    }
    else if(widget.taskStatus==TaskStatus.cancel){
      return Colors.red;
    }
    return Colors.grey;
  }

  void _showUpdateStatusDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
       title: Text("Update Status"),
       content: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           ListTile(
             onTap: (){
               _popDialog();
               if(isSelected('New'))return;
               _changeTaskStatus('New');
             },
             title: Text("New"),
             trailing: isSelected('New') ? Icon(Icons.done) : null,
           ),
           ListTile(
             onTap: (){
               _popDialog();
               if(isSelected('Progress'))return;
               _changeTaskStatus('Progress');
             },
             title: Text("Progress"),
             trailing: isSelected('Progress') ? Icon(Icons.done) : null,
           ),
           ListTile(
             onTap: (){
               _popDialog();
               if(isSelected('Completed'))return;
               _changeTaskStatus('Completed');
             },
             title: Text("Completed"),
             trailing: isSelected('Completed') ? Icon(Icons.done) : null,
           ),
           ListTile(
             onTap: (){
               _popDialog();
               if(isSelected('Cancel'))return;
               _changeTaskStatus('Cancel');
             },
             title: Text("Cancel"),
             trailing: isSelected('Cancel') ? Icon(Icons.done) : null,
           ),
         ],
       ),
      );
    });
  }

  void _popDialog(){
    Navigator.pop(context);
  }

  bool isSelected(String status)=>widget.taskModel.status==status;


  Future<void> _changeTaskStatus(String status)async{
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id,status));

    _inProgress = false;


    if(response.isSuccess){
      widget.refreshList();
    }else{
      setState(() {});
      showSnackBarMessage(context, response.errorMessage,true);
    }
  }

}