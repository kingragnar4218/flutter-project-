class User{
  late int _UserID;
  late String _FirstName;
  late String _LastName;
  late String _Email;
  late String _Mobile;
  late String _DOB;
  late String _City;
  late String _Gender;
  late String _Hobbies;
  late String _Password;
  bool _isFavourite=false;


  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
  }

  int get UserID => _UserID;

  set UserID(int value) {
    _UserID = value;
  }

  String get FirstName => _FirstName;

  String get Password => _Password;

  set Password(String value) {
    _Password = value;
  }

  String get Hobbies => _Hobbies;

  set Hobbies(String value) {
    _Hobbies = value;
  }

  String get Gender => _Gender;

  set Gender(String value) {
    _Gender = value;
  }

  String get City => _City;

  set City(String value) {
    _City = value;
  }

  String get DOB => _DOB;

  set DOB(String value) {
    _DOB = value;
  }

  String get Mobile => _Mobile;

  set Mobile(String value) {
    _Mobile = value;
  }

  String get Email => _Email;

  set Email(String value) {
    _Email = value;
  }

  String get LastName => _LastName;

  set LastName(String value) {
    _LastName = value;
  }

  set FirstName(String value) {
    _FirstName = value;
  }


  @override
  String toString() {
    return 'User{_UserID: $_UserID, _FirstName: $_FirstName, _LastName: $_LastName, _Email: $_Email, _Mobile: $_Mobile, _DOB: $_DOB, _City: $_City, _Gender: $_Gender, _Hobbies: $_Hobbies, _Password: $_Password, _isFavourite: $_isFavourite}';
  }

  Map<String, dynamic> toMap() {
    return {
      'FirstName': this._FirstName,
      'LastName': this._LastName,
      'Email': this._Email,
      'Mobile': this._Mobile,
      'DOB': this._DOB,
      'City': this._City,
      'Gender': this._Gender,
      'Hobbies': this._Hobbies,
      'Password': this._Password,
      'isFavourite': this._isFavourite,
    };
  }

}