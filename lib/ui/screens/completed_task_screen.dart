import 'package:flutter/material.dart';
import 'package:taskmanagement_live/data/models/task_model.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool _getCompletedTaskInComplete = false;
  List<TaskModel> _completedTaskLiist = [];

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCompletedTaskInComplete ==false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _completedTaskLiist.length,
          itemBuilder: (context,index){
            return Taskcard(

              taskStatus: TaskStatus.completed,
              taskModel: _completedTaskLiist[index],
              refreshList: _getAllCompletedTaskList,

            );
          }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    _getCompletedTaskInComplete = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.CompletedTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskLiist = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getCompletedTaskInComplete = false;
    setState(() {});
  }

}



