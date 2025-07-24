import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/ui/controllers/progress_task_list_controller.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProgressTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.getProgressTaskInProgress==false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.progressTaskList.length,
              itemBuilder: (context,index){
                return  Taskcard(
                  taskStatus: TaskStatus.progress,
                  taskModel: controller.progressTaskList[index],
                  refreshList: _getAllProgressTaskList,

                );
              }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),),
          );
        }
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {

    bool isSuccess = await Get.find<ProgressTaskListController>().getAllProgressTaskList();

    if (!isSuccess) {
      showSnackBarMessage(context, Get.find<ProgressTaskListController>().errorMessage!,true);
    }
  }

}



