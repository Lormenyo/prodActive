import 'package:flutter/material.dart';
import 'package:prodactive/onbarding.dart';
import 'package:prodactive/todoList.dart';
import 'package:prodactive/todoListModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ProdActive',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Onboarding(),
        ),
        routes: {"/todo": (context) => TodoList()},
      ),
    );
  }
}
