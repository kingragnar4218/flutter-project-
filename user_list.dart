import 'package:flutter/material.dart';
import 'dbHelper.dart';
import 'registration_screen.dart';
import 'user.dart';

class UserList extends StatefulWidget {
  bool fromFav;

  UserList({super.key, this.fromFav = false});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<User>>(
        future:
        widget.fromFav
            ? dbHelper.getAllFavouriteUser()
            : dbHelper.getAllUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            label(
                              icon: Icons.person,
                              txt:
                              "${users[index].FirstName} ${users[index].LastName}",
                            ),
                            label(
                              icon: Icons.location_city,
                              txt: users[index].City,
                            ),
                            label(icon: Icons.phone, txt: users[index].Mobile),
                            label(icon: Icons.mail, txt: users[index].Email),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              dbHelper.setFavourite(
                                users[index].UserID,
                                !users[index].isFavourite,
                              );
                              setState(() {});
                            },
                            icon: Icon(
                              users[index].isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => RegistrationScreen(
                                    user: users[index],
                                  ),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              dbHelper.deleteUser(users[index].UserID);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No Data Found"));
          }
        },
      ),
    );
  }

  Widget label({icon, txt}) {
    return Row(children: [Icon(icon), Expanded(child: Text(txt))]);
  }
}
