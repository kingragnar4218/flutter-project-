import 'dart:math';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'user_list.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  PageController pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.6,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Row(
                children: [
                  dashboardButton(
                    context,
                    title: "Add User",
                    image: "assets/image/registration.png",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                  ),
                  dashboardButton(
                    context,
                    title: "User List",
                    image: "assets/image/customer.png",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserList()),
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  dashboardButton(
                    context,
                    title: "Favorite",
                    image: "assets/image/heart.png",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserList(fromFav: true),
                        ),
                      );
                    },
                  ),
                  dashboardButton(
                    context,
                    title: "About Us",
                    image: "assets/image/profile.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardButton(context, {required image, required title, onClick}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        height: 150,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          color: Colors.white,
          child: InkWell(
            onTap: onClick,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, height: 70, width: 70, color: Colors.red),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* SizedBox(
                height: 500,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(8),
                      child: Image.asset(
                        "assets/image/bird${index + 1}.jpg",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),*/
