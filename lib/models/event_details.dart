import 'package:firebase_database/firebase_database.dart';

class EventDetails {
  String evenImageUrl;
  String eventName;
  String eventLocation;
  String eventDate;
  String eventTiming;
  String numOfParticipants;
  String eventDesc;
  String organizerName;
  String presenterName;
  String organizernote;
  String organizerPic;

  EventDetails({
    required this.evenImageUrl,
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
    required this.eventTiming,
    required this.numOfParticipants,
    required this.eventDesc,
    required this.organizerName,
    required this.presenterName,
    required this.organizernote,
    required this.organizerPic,
  });

  // Method to convert EventDetails object to Map
  Map<String, dynamic> toMap() {
    return {
      'evenImageUrl': evenImageUrl,
      'eventName': eventName,
      'eventLocation': eventLocation,
      'eventDate': eventDate,
      'eventTiming': eventTiming,
      'numOfParticipants': numOfParticipants,
      'eventDesc': eventDesc,
      'organizerName': organizerName,
      'presenterName': presenterName,
      'organizernote': organizernote,
      'organizerPic': organizerPic
    };
  }

  // Static method to create EventDetails object from Map
  static EventDetails fromMap(Map<dynamic, dynamic> map) {
    return EventDetails(
        evenImageUrl: map['evenImageUrl'],
        eventName: map['eventName'],
        eventLocation: map['eventLocation'],
        eventDate: map['eventDate'],
        eventTiming: map['eventTiming'],
        numOfParticipants: map['numOfParticipants'],
        eventDesc: map['eventDesc'],
        organizerName: map['organizerName'],
        presenterName: map['presenterName'],
        organizernote: map['organizernote'],
        organizerPic: map['organizerPic']);
  }
}
