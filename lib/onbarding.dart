import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/onboarding-1.png"),
          Text("Get your tasks organised and Be Productive"),
          SizedBox(
            height: 150,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.black,
              width: 350,
              child: RaisedButton(
                  elevation: 2,
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/todo");
                  }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
