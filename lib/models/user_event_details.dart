class UserEventDetails {
  String eID;
  String stID;
  String dateJoined;

  UserEventDetails({
    required this.eID,
    required this.stID,
    required this.dateJoined,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      "eID": eID,
      "stID": stID,
      "dateJoined": dateJoined,
    };
  }

  factory UserEventDetails.fromMap(Map<dynamic, dynamic> map) {
    return UserEventDetails(
      eID: map["eID"],
      stID: map["stID"],
      dateJoined: map["dateJoined"],
    );
  }

  
}
