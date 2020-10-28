import 'package:flutter/cupertino.dart';


class TodoListModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTasks(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}

class Task {
  String taskTitle;
  bool isCompleted;

  Task({@required this.taskTitle}) {
    this.isCompleted = false;
  }
}
