// ignore_for_file: constant_identifier_names

class UserDetails {
  String fName;
  String lName;
  String email;
  String password;
  String phoneNum;
  String studentId;
  String major;
  List<String> eventlist;
  int points;

  UserDetails({
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    required this.phoneNum,
    required this.studentId,
    required this.major,
    required this.eventlist,
    required this.points,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "fName": fName,
      "lName": lName,
      "email": email,
      "password": password,
      "phoneNum": phoneNum,
      "studentId": studentId,
      "major": major,
      "eventlist": eventlist,
      "points": points,
    };
  }

  factory UserDetails.fromMap(Map<dynamic, dynamic> map) {
    return UserDetails(
      fName: map["fName"],
      lName: map["lName"],
      email: map["email"],
      password: map["password"],
      phoneNum: map["phoneNum"],
      studentId: map["studentId"],
      major: map["major"],
      eventlist: map["eventlist"],
      points: map["points"],
    );
  }
}
