import 'package:flutter/material.dart';
import 'package:taskmanagement_live/data/models/task_list_model.dart';
import 'package:taskmanagement_live/data/models/task_status_count_list_model.dart';
import 'package:taskmanagement_live/data/models/task_status_count_model.dart';
import 'package:taskmanagement_live/data/service/network_client.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/screens/add_new_task_screen.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:taskmanagement_live/ui/widgets/snack_bar_message.dart';
import '../../data/models/task_model.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgreess = false;

  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool _getNewTaskInProgreess = false;

  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getStatusCountInProgreess==false,
                replacement:Padding(padding: EdgeInsets.all(16), child: const CenteredCircularProgressIndicator()),
                child: _buildSummarySection()
            ),
            Visibility(
              visible: _getNewTaskInProgreess==false,
              replacement:SizedBox(height: 300, child: const CenteredCircularProgressIndicator()),
              child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return  Taskcard(
                    taskStatus: TaskStatus.sNew,
                    taskModel: _newTaskList[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskStatusCountList.length,
            itemBuilder: (context, index) {
              return summaryCard(
                  title: _taskStatusCountList[index].status,
                  count: _taskStatusCountList[index].count);
            }),
      ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgreess = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getStatusCountInProgreess = false;
    setState(() {});
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskInProgreess = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.newTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }

    _getNewTaskInProgreess = false;
    setState(() {});
  }
}
