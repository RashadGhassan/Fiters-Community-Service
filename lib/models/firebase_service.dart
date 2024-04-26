import 'package:community_service/models/event_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:community_service/models/user_details.dart';

class FirebaseService {
  Future<UserDetails?> getUserDetails(String useruid) async {
    try {
      DatabaseReference refh = FirebaseDatabase.instance.ref().child("users");
      DatabaseEvent event = await refh.child(useruid).once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> snapdata = event.snapshot.value as dynamic;
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
        print(event.snapshot.value.toString());

        List<EventDetails> productList = [];
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;

        snapshotData.forEach((key, value) {
          productList.add(EventDetails.fromMap(value as Map<dynamic, dynamic>));
        });

        print("Product List: $productList");
        return productList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting product details: $e');
      return [];
    }
  }
}
