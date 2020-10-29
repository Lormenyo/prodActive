import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prodactive/databaseHelper.dart';
import 'package:prodactive/todoListModel.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  TextEditingController taskFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TodoListModel todos = Provider.of<TodoListModel>(context);
    // DatabaseHelper.instance.clearTable();
    // var todos = context.watch<TodoListModel>();
    List<Task> tasks = todos.allTasks;
    print("printing ffssfs");
    print(tasks.length);

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg-1.jpg"), fit: BoxFit.cover)),
        ),
        Positioned(
          top: 50,
          left: 25,
          child: Text(
            "My Tasks",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100),
          child: ListView.builder(
            itemCount: todos.allTasks.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(style: BorderStyle.none)),
                  leading: IconButton(
                      icon: todos.allTasks[index].isCompleted
                          ? Icon(Icons.radio_button_checked)
                          : Icon(Icons.radio_button_unchecked),
                      onPressed: () {
                        todos.deleteTasks(todos.allTasks[index]);
                      }),
                  title: Text(todos.allTasks[index].taskTitle),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 30,
          right: 10,
          child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.grey,
              onPressed: () {
                showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 200,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 350,
                                  child: TextFormField(
                                      controller: taskFieldController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Do Something...",
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        )),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.black)),
                                    child: Text("Add new task"),
                                    onPressed: () {
                                      todos.addTask(Task(
                                          taskTitle: taskFieldController.text));
                                      taskFieldController.clear();
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ],
    );
  }
}
