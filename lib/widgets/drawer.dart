import 'package:flutter/material.dart';
import 'package:community_service/widgets/drawerListTile.dart';
import 'package:community_service/models/firebase_service.dart';
import 'package:community_service/models/user_auth.dart';
import 'package:community_service/models/user_details.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 350,
      child: ListView(
        children: [
          FutureBuilder(
              future: FirebaseService()
                  .getUserDetails(Auth().auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print("===================================");
                  print(FirebaseService()
                      .getUserDetails(Auth().auth.currentUser!.uid));
                  print(snapshot.data);
                  print("===================================");
                  UserDetails user = snapshot.data!;
                  return DrawerHeader(
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 30,
                                color: Color(0x20000000),
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            maxRadius: 24,
                            backgroundColor: Color(0xffF8F8FF),
                            child: Text(
                              "${user.fName.toString()[0]}${user.lName.toString()[0]}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff8A8B8B),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        title: Text(
                          "${user.fName.toString()} ${user.lName.toString()}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          user.email.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/profileScreen");
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          DrawerListTile(
            title: "Home",
            icon: Icon(Icons.home),
            navigateTo: "/homeScreen",
          ),
          Builder(builder: (context) {
            if (Auth().auth.currentUser!.email!.endsWith("@asu.edu.jo")) {
              return DrawerListTile(
                title: "Create Event",
                icon: Icon(Icons.event_note),
                navigateTo: "/createEventInfoScreen",
              );
            } else {
              return SizedBox();
            }
          }),
          DrawerListTile(
            title: "Dashboard",
            icon: Icon(Icons.bar_chart),
            navigateTo: "/dashScreen",
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icon(Icons.settings),
            navigateTo: "/settingsScreen",
          ),
        ],
      ),
    );
  }
}
