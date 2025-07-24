import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/ui/controllers/completed_task_list_controller.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskLIstController>(
        builder: (controller) {
          return Visibility(
            visible: controller.getCompletedTaskInComplete ==false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.completedTaskLiist.length,
              itemBuilder: (context,index){
                return Taskcard(

                  taskStatus: TaskStatus.completed,
                  taskModel: controller.completedTaskLiist[index],
                  refreshList: _getAllCompletedTaskList,

                );
              }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),),
          );
        }
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    bool isSuccess = await Get.find<CompletedTaskLIstController>().getAllCompletedTaskList();

    if (!isSuccess) {
      showSnackBarMessage(context, Get.find<CompletedTaskLIstController>().errorMessage!, true);
    }
    }

}



