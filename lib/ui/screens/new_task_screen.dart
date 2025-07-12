import 'package:flutter/material.dart';
import 'package:taskmanagement_live/ui/screens/add_new_task_screen.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              summaryCard(
                title: 'New',
                count: 12,
              ),
              summaryCard(
                title: 'Progress',
                count: 23,
              ),
              summaryCard(
                title: 'Completed',
                count: 32,
              ),
              summaryCard(
                title: 'Cancelled',
                count: 50,
              ),
            ],
          ),
        );
  }
}



