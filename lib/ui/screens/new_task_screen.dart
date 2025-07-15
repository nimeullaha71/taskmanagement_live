import 'package:flutter/material.dart';
import 'package:taskmanagement_live/data/models/task_status_count_list_model.dart';
import 'package:taskmanagement_live/data/models/task_status_count_model.dart';
import 'package:taskmanagement_live/data/service/network_client.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/screens/add_new_task_screen.dart';
import 'package:taskmanagement_live/ui/widgets/snack_bar_message.dart';
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

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummarySection(),
            ListView.separated(
              primary: false,
                shrinkWrap: true,
                itemCount: 6,
              itemBuilder: (context,index){
                  return const Taskcard(taskStatus: TaskStatus.sNew,);
              }, separatorBuilder: (context,index)=>const SizedBox(height: 8,),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewTask,child:const Icon(Icons.add),),
    );
  }


  void _onTapAddNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: EdgeInsets.all(8),

      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskStatusCountList.length,
            itemBuilder: (context,index){
          return summaryCard(title: _taskStatusCountList[index].status, count: _taskStatusCountList[index].count);
        }),
      ),
    );
  }
  
  Future<void> _getAllTaskStatusCount()async{
    _getStatusCountInProgreess=true;
    setState(() {});
    final NetworkResponse response =await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    }
    else{
      showSnackBarMessage(context, response.errorMessage,true);
    }

    _getStatusCountInProgreess =false;
    setState(() {});
  }
  
}



