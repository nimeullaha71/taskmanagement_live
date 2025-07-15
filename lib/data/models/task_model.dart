// "_id": "6874f3206a37c12cf5064145",
// "title": "title",
// "description": "dfgdf",
// "status": "New",
// "email": "nimeullaha7@gmail.com",
// "createdDate": "2025-06-01T19:36:50.148Z"


class TaskModel {
  late final String id;
  late final String title;
  late final String description;
  late final String status;
  late final String createdDate;



  TaskModel.fromJson(Map<String,dynamic>jsonData){
    id = jsonData['_id'];
    title = jsonData['title'] ?? "";
    description = jsonData['description'] ?? "";
    status = jsonData['status'];
    createdDate = jsonData['createdDate'] ?? "";
  }

}