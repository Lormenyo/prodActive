import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prodactive/todoListModel.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoListModel todos = Provider.of<TodoListModel>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Expanded(
                  child: ListView.builder(
                itemCount: todos.allTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton(
                        icon: todos.allTasks[index].isCompleted
                            ? Icon(Icons.radio_button_checked)
                            : Icon(Icons.radio_button_unchecked),
                        onPressed: () {
                          todos.deleteTasks(todos.allTasks[index]);
                        }),
                    title: Text(todos.allTasks[index].taskTitle),
                  );
                },
              )),
            ),
          ],
        ),
      ),
      floatingActionButton: RaisedButton(onPressed: () {
        showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                // child: ,
                color: Colors.blue,
              );
            });
      }),
    );
  }
}
