import 'package:flutter/material.dart';
import 'package:taskmanagement_live/data/models/task_model.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool _getCanceledTaskInCanceled = false;
  List<TaskModel> _canceledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCanceledTaskInCanceled==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _canceledTaskList.length,
          itemBuilder: (context,index){
            return  Taskcard(
              taskStatus: TaskStatus.cancel,
              taskModel: _canceledTaskList[index], refreshList: _getAllCancelledTaskList,

            );
          }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),),
      ),
    );
  }


  Future<void> _getAllCancelledTaskList() async {
    _getCanceledTaskInCanceled = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.CanceledTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _canceledTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getCanceledTaskInCanceled = false;
    setState(() {});
  }


}



