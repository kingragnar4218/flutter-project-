import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'user.dart';

class Insertuser extends StatefulWidget {
  const Insertuser({super.key});

  @override
  State<Insertuser> createState() => _InsertuserState();
}

class _InsertuserState extends State<Insertuser> {
  int userCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              User user = User();
              user.FirstName = "Raj";
              user.LastName = "Gondaliya";
              user.Email = "raj@gmail.com";
              user.Mobile = "9784561230";
              user.Password = "";
              user.Hobbies = "";
              user.Gender = "Male";
              user.City = "Rajkot";
              user.DOB = DateTime.now().toIso8601String();

              DBHelper db = DBHelper();
              userCount = await db.insertUser(user);
              setState(() {

              });
            },
            child: Text("Insert Use"),
          ),
          Text("Count=$userCount"),
        ],
      ),
    );
  }
}
