
/*
Future<void> getUser() async {
  Database db = await initDatabase();
  List<Map<String, Object?>> data = await db.query("User");
  print(data.last.toString());
}*/


/*
Future<void> insertUser() async {
  User user = User();
  user.FirstName = firstNameController.text;
  user.LastName = lastNameController.text;
  user.Email = emailController.text;
  user.Mobile = mobileController.text;
  user.DOB = selectedDate.toIso8601String();
  user.City = cityController.text;
  user.Gender = gender;
  user.Password = passwordController.text;
  user.Hobbies = jsonEncode(selectedHobbies);
  DBHelper dbHelper = DBHelper();
  dbHelper.insertUser(user).then((value) {
    if (value != 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data Insert Successfully!!!")));
      clear();
    }
  });

  dbHelper.getUser();
}*/
