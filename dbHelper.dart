import 'user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "userinfo.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE User (UserID INTEGER PRIMARY KEY AUTOINCREMENT, FirstName VARCHAR(500), LastName VARCHAR(500), Email VARCHAR(500), Mobile VARCHAR(200), DOB VARCHAR(200), City VARCHAR(100), Gender VARCHAR(50), Hobbies VARCHAR(100), Password VARCHAR(200),isFavourite BOOLEAN)",
        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    Database db = await initDatabase();

    /* Map<String, Object?> values={
      "FirstName":user.FirstName,
      "LastName":user.LastName,
      "Email":user.Email,
    };*/
    return db.insert("User", user.toMap());
  }

  Future<int> updateUser(User user) async {
    Database db = await initDatabase();
    return db.update(
      "User",
      user.toMap(),
      where: "UserID=?",
      whereArgs: [user.UserID],
    );
  }

  Future<List<User>> getAllUser() async {
    List<User> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> usersMap = await db.query("User");
    usersMap.forEach((element) {
      User user = User();
      user.UserID = int.parse(element["UserID"].toString());
      user.FirstName = element["FirstName"].toString();
      user.LastName = element["LastName"].toString();
      user.Email = element["Email"].toString();
      user.Hobbies = element["Hobbies"].toString();
      user.Gender = element["Gender"].toString();
      user.City = element["City"].toString();
      user.Password = element["Password"].toString();
      user.DOB = element["DOB"].toString();
      user.Mobile = element["Mobile"].toString();
      user.isFavourite = element["isFavourite"].toString() == "1";
      userList.add(user);
    });
    return userList;
  }

  Future<List<User>> getAllFavouriteUser() async {
    List<User> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> usersMap = await db.query(
      "User",
      where: "isFavourite=?",
      whereArgs: ["1"],
    );
    usersMap.forEach((element) {
      User user = User();
      user.UserID = int.parse(element["UserID"].toString());
      user.FirstName = element["FirstName"].toString();
      user.LastName = element["LastName"].toString();
      user.Email = element["Email"].toString();
      user.Hobbies = element["Hobbies"].toString();
      user.Gender = element["Gender"].toString();
      user.City = element["City"].toString();
      user.Password = element["Password"].toString();
      user.DOB = element["DOB"].toString();
      user.Mobile = element["Mobile"].toString();
      user.isFavourite = element["isFavourite"].toString() == "1";
      userList.add(user);
    });
    return userList;
  }

  Future<void> setFavourite(int userID, bool isFav) async {
    print("userID=$userID isFav=$isFav");
    Database db = await initDatabase();
    db.execute("UPDATE User set isFavourite=? WHERE UserID=?", [isFav, userID]);
  }

  Future<void> deleteUser(int userID) async {
    Database db = await initDatabase();
    db.delete("User", where: "UserID=?", whereArgs: [userID]);
  }
}
