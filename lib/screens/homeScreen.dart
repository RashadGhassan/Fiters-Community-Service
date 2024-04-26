import 'package:community_service/models/event_details.dart';
import 'package:community_service/models/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:community_service/widgets/drawer.dart';
import 'package:community_service/widgets/eventCard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder(
        future: FirebaseService().getProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<EventDetails> elist = snapshot.data!;
            return ListView.builder(
              itemCount: elist.length,
              itemBuilder: (BuildContext context, int index) {
                return EventCard(
                  eventDetails: elist[index],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
