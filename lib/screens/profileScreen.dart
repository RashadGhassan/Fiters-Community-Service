import 'package:flutter/material.dart';
import 'package:community_service/models/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:community_service/models/user_details.dart';
// import 'package:community_service/widgets/drawer.dart';
import 'package:community_service/models/firebase_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: UserProfile(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF144E73),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserDetails? user;
  final FirebaseService firebaseService = FirebaseService();
  final User? usr = Auth().auth.currentUser;
  @override
  void initState() {
    super.initState();
    print(usr?.uid);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      UserDetails? userData = await firebaseService.getUserDetails(usr!.uid);
      if (userData != null) {
        setState(() {
          user = userData;
        });
      } else {
        // Handle user not found
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 30,
                                color: Color(0x20000000),
                                spreadRadius: 5)
                          ],
                        ),
                        child: CircleAvatar(
                          maxRadius: 60,
                          minRadius: 25,
                          backgroundColor: Color(0xffF8F8FF),
                          child: Text(
                            "${user!.fName.toString()[0]}${user!.lName.toString()[0]}",
                            style: TextStyle(
                                fontSize: 50,
                                color: Color(0xFF8A8B8B),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${user!.fName.toString()} ${user!.lName.toString()}",
                            style: TextStyle(
                              color: Color(0xff141617),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "${user!.major.toString()}",
                            style: TextStyle(
                              color: Color(0xff8A8B8B),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Color(0xff8A8B8B),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${user!.email.toString()}",
                        style: TextStyle(
                          color: Color(0xff8A8B8B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Color(0xff8A8B8B),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${user!.phoneNum.toString()}",
                        style: TextStyle(
                          color: Color(0xff8A8B8B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(),
          ],
        ),
      );
    }
  }
}
