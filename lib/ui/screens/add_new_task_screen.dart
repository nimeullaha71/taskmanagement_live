import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement_live/data/service/network_client.dart';
import 'package:taskmanagement_live/data/utils/urls.dart';
import 'package:taskmanagement_live/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanagement_live/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:taskmanagement_live/ui/widgets/screen_background.dart';
import 'package:taskmanagement_live/ui/widgets/snack_bar_message.dart';
import 'package:taskmanagement_live/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Description",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your Description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AddNewTaskController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.addNewTaskInProgress ==false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: _onTapSubmitButton,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {

    bool isSuccess = await Get.find<AddNewTaskController>().addNewTask(_titleTEController.text, _descriptionTEController.text);


    if(isSuccess){
      _clearTextFields();
      showSnackBarMessage(context, 'New Task Added !');
    }
    else{
      showSnackBarMessage(context, Get.find<AddNewTaskController>().errorMessage!,true);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }

}
