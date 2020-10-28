import 'package:flutter/cupertino.dart';

import 'databaseHelper.dart';

class TodoListModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get allTasks {
    DatabaseHelper.instance.queryAllRows().then((value) {
      value.forEach((element) {
        _tasks.add(Task(taskTitle: element["title"]));
      });
    });
    return _tasks;
  }

  void addTask(Task task) async {
    var id = await DatabaseHelper.instance.insert(task);
    _tasks.insert(0, Task(id: id, taskTitle: task.taskTitle));
    notifyListeners();
  }

  void deleteTasks(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  //   void _deleteTask(int id) async {
  //   await DatabaseHelper.instance.delete(id);
  //   setState(() {
  //     taskList.removeWhere((element) => element.id == id);
  //   });
  // }

}

class Task {
  int id;
  String taskTitle;
  bool isCompleted;

  Task({@required this.taskTitle, this.id}) {
    this.isCompleted = false;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': taskTitle, 'isCompleted': isCompleted};
  }
}
