import 'package:flutter/cupertino.dart';
import 'databaseHelper.dart';
import 'package:provider/provider.dart';

class TodoListModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;

  setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void getTasks() async {
    await DatabaseHelper.instance.queryAllRows().then((List<Task> value) {
      setTasks(value);
    });
  }

  void addTask(Task task) async {
    var id = await DatabaseHelper.instance.insert(task);
    //check if the task already exists
    if ((_tasks.indexWhere((task) => task.id == id)) == -1) {
      _tasks.insert(0, Task(id: id, taskTitle: task.taskTitle));
      notifyListeners();
    }
  }

  void deleteTasks(Task task) async {
    task.isCompleted = true;
    int id = await DatabaseHelper.instance.delete(task.id);
    print(id);
    // if ((_tasks.indexWhere((task) => task.id == id)) != -1) {
    print("www");
    _tasks.remove(Task(id: id, taskTitle: task.taskTitle));
    setTasks(_tasks);
    notifyListeners();
    // }
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
