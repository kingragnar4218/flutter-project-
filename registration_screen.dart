import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ✅ This was missing
import 'dbHelper.dart';
import 'user.dart';

class RegistrationScreen extends StatefulWidget {
  User? user;

  RegistrationScreen({this.user});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String gender = "Male";
  List<String> selectedHobbies = [];
  List<String> hobbyList = ["Reading", "Sports", "Music", "Travel"];
  DateTime selectedDOB = DateTime.now();

  @override
  void initState() {
    super.initState();
    setUserData();
    dobController.text = DateFormat("dd/MM/yyyy").format(selectedDOB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Form")),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          EditTextWidget(
            txtcontroller: firstNameController,
            hint: "Enter First Name",
            keyboardType: TextInputType.name,
          ),
          EditTextWidget(
            txtcontroller: lastNameController,
            hint: "Enter Last Name",
            keyboardType: TextInputType.name,
          ),
          EditTextWidget(
            txtcontroller: emailController,
            hint: "Enter Email",
            keyboardType: TextInputType.emailAddress,
          ),
          EditTextWidget(
            txtcontroller: mobileController,
            hint: "Enter Mobile",
            keyboardType: TextInputType.phone,
          ),
          EditTextWidget(
            txtcontroller: cityController,
            hint: "Enter City",
            keyboardType: TextInputType.name,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // dismiss keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDOB,
                  firstDate: DateTime(1925),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  selectedDOB = pickedDate;
                  dobController.text = DateFormat("dd/MM/yyyy").format(selectedDOB);
                  setState(() {});
                }
              },
              readOnly: true,
              controller: dobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Select Date of Birth",
              ),
            ),
          ),
          EditTextWidget(
            txtcontroller: passwordController,
            hint: "Enter Password",
            isPassword: true,
          ),
          SizedBox(height: 12),
          Text("Select Gender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          RadioListTile(
            title: Text("Male"),
            secondary: Icon(Icons.male),
            value: "Male",
            groupValue: gender,
            onChanged: (value) {
              gender = value!;
              setState(() {});
            },
          ),
          RadioListTile(
            title: Text("Female"),
            secondary: Icon(Icons.female),
            value: "Female",
            groupValue: gender,
            onChanged: (value) {
              gender = value!;
              setState(() {});
            },
          ),
          Text("Hobbies:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: hobbyList
                .map((hobby) => CheckboxListTile(
              title: Text(hobby),
              controlAffinity: ListTileControlAffinity.leading,
              value: selectedHobbies.contains(hobby),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    selectedHobbies.add(hobby);
                  } else {
                    selectedHobbies.remove(hobby);
                  }
                });
              },
            ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: insertUser,
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {
                  clear();
                  setState(() {});
                },
                child: Text("Clear"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget EditTextWidget({
    required TextEditingController txtcontroller,
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: isPassword,
        controller: txtcontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hint,
        ),
      ),
    );
  }

  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileController.clear();
    selectedDOB = DateTime.now();
    dobController.text = DateFormat("dd/MM/yyyy").format(selectedDOB);
    cityController.clear();
    passwordController.clear();
    selectedHobbies.clear();
    gender = "Male";
  }

  void setUserData() {
    if (widget.user != null) {
      firstNameController.text = widget.user!.FirstName;
      lastNameController.text = widget.user!.LastName;
      emailController.text = widget.user!.Email;
      mobileController.text = widget.user!.Mobile;
      cityController.text = widget.user!.City;
      passwordController.text = widget.user!.Password;
      selectedHobbies = List<String>.from(jsonDecode(widget.user!.Hobbies));
      selectedDOB = DateTime.parse(widget.user!.DOB);
      dobController.text = DateFormat("dd/MM/yyyy").format(selectedDOB);
      gender = widget.user!.Gender;
    }
  }

  Future<void> insertUser() async {
    DBHelper db = DBHelper();
    User user = User()
      ..FirstName = firstNameController.text
      ..LastName = lastNameController.text
      ..Email = emailController.text
      ..Hobbies = jsonEncode(selectedHobbies)
      ..Gender = gender
      ..City = cityController.text
      ..Password = passwordController.text
      ..DOB = selectedDOB.toIso8601String()
      ..Mobile = mobileController.text;

    if (widget.user == null) {
      db.insertUser(user).then((value) {
        if (value != 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data added successfully!")));
          clear();
          setState(() {});
        }
      });
    } else {
      user.UserID = widget.user!.UserID;
      user.isFavourite = widget.user!.isFavourite;
      db.updateUser(user).then((value) {
        if (value != 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data updated successfully!")));
          clear();
          Navigator.pop(context);
        }
      });
    }
  }
}
