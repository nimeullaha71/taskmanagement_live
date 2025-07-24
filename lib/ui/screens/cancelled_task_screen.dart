import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/data/models/task_model.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/controllers/cancelled_list_controller.dart';
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


  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskListController>(
        builder: (controller) {
          return Visibility(
            visible: controller.getCanceledTaskInCanceled ==false,
            replacement: CenteredCircularProgressIndicator(),
            child: ListView.separated(
              itemCount: controller.canceledTaskList.length,
              itemBuilder: (context,index){
                return  Taskcard(
                  taskStatus: TaskStatus.cancel,
                  taskModel: controller.canceledTaskList[index], refreshList: _getAllCancelledTaskList,

                );
              }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),),
          );
        }
      ),
    );
  }


  Future<void> _getAllCancelledTaskList() async {

    bool isSuccess = await Get.find<CancelledTaskListController>().getAllCancelledTaskList();

      if (!isSuccess) {
        showSnackBarMessage(context, Get.find<CancelledTaskListController>().errorMessage!, true);
      }
  }


}



