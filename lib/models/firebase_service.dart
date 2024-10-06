import 'package:community_service/models/event_details.dart';
import 'package:community_service/models/user_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:community_service/models/user_details.dart';

import 'user_event_details.dart';

class FirebaseService {
  Future<UserDetails?> getUserDetails(String useruid) async {
    try {
      DatabaseReference refh = FirebaseDatabase.instance.ref().child("users");
      DatabaseEvent event = await refh.child(useruid).once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> snapdata = event.snapshot.value as dynamic;
        print(snapdata);
        return UserDetails.fromMap(snapdata);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print("here ---> ${e.toString()}");
    }
    return null;
  }

  Future<List<EventDetails>> getProductDetails() async {
    try {
      DatabaseReference productsRef =
          FirebaseDatabase.instance.ref().child("events");

      DatabaseEvent event = await productsRef.once();

      if (event.snapshot.value != null) {
        List<EventDetails> productList = [];
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;
        snapshotData.forEach((key, value) {
          productList.add(EventDetails.fromMap(value as Map<dynamic, dynamic>));
          productList.last.eventID = key;
        });
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting product details: $e');
      return [];
    }
  }

//testing
  Future<EventDetails> getProductDetailsByEventId(String eid) async {
    try {
      DatabaseReference productsRef =
          FirebaseDatabase.instance.ref().child("events");

      DatabaseEvent event = await productsRef.once();

      if (event.snapshot.value != null) {
        var resultEvent;
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;
        snapshotData.forEach((key, value) {
          if (key == eid) {
            resultEvent = EventDetails.fromMap(value as Map<dynamic, dynamic>);
          }
        });
        return resultEvent;
      } else {
        return null!;
      }
    } catch (e) {
      print('Error getting product details: $e');
      return null!;
    }
  }

  Future<List<UserEventDetails>> getUserEventDetails() async {
    try {
      DatabaseReference joinedEventsRef =
          FirebaseDatabase.instance.ref().child("userEvents");
      DatabaseEvent event = await joinedEventsRef.once();

      DatabaseReference refh = FirebaseDatabase.instance.ref().child("users");
      DatabaseEvent user =
          await refh.child(Auth().auth.currentUser!.uid).once();

      if (event.snapshot.value != null) {
        List<UserEventDetails> userEventList = [];
        Map<dynamic, dynamic> snapshotDataEvent =
            event.snapshot.value as dynamic;
        Map<dynamic, dynamic> snapshotDataUser = user.snapshot.value as dynamic;
        snapshotDataEvent.forEach((key, value) {
          if (snapshotDataUser["studentId"] == value["stID"]) {
            userEventList
                .add(UserEventDetails.fromMap(value as Map<dynamic, dynamic>));
          }
        });
        return userEventList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting product details: $e');
      return [];
    }
  }
}
