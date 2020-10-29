import 'package:flutter/cupertino.dart';

import 'databaseHelper.dart';

List<Task> getTasks() {
  List<Task> tasks = List();
  DatabaseHelper.instance.queryAllRows().then((value) {
    value.forEach((task) {
      tasks.insert(0, task);
    });
  });
  print(tasks);
  return tasks;
}

class TodoListModel extends ChangeNotifier {
  static List<Task> _tasks = getTasks();

  List<Task> get allTasks => _tasks;

  void addTask(Task task) async {
    var id = await DatabaseHelper.instance.insert(task);
    //check if the task already exists
    if ((_tasks.indexWhere((task) => task.id == id)) == -1) {
      _tasks.insert(0, Task(id: id, taskTitle: task.taskTitle));
      notifyListeners();
    }
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
