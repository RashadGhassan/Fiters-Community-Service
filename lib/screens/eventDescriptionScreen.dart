import 'package:community_service/models/event_details.dart';
import 'package:community_service/models/firebase_service.dart';
import 'package:community_service/models/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_details.dart';
import '../models/user_event_details.dart';

class EventDescription extends StatefulWidget {
  final EventDetails eventDetails;
  const EventDescription({super.key, required this.eventDetails});

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  // const EventDescription({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Color(0x15000000),
                      spreadRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  widget.eventDetails.evenImageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.eventDetails.eventName}",
                      // "Linkedin Workshop",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.eventDetails.eventLocation}",
                          // "FINC",
                          style: TextStyle(
                            fontSize: 16,
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
                          Icons.calendar_month_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.eventDetails.eventDate}",
                          // "07/06/2024",
                          style: TextStyle(
                            fontSize: 16,
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
                          Icons.alarm_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.eventDetails.eventTiming}",
                          // "11:00 am - 12:00 pm",
                          style: TextStyle(
                            fontSize: 16,
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
                          Icons.group,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.eventDetails.numOfParticipants}",
                          // "25 people",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "${widget.eventDetails.eventDesc}",
                      // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Organized by:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.eventDetails.organizerPic),
                          maxRadius: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "${widget.eventDetails.organizerName}",
                          // "Software Engineering Club",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Presenters:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("${widget.eventDetails.presenterName}"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
        color: Color(0x00000000),
        child: ElevatedButton(
          onPressed: () {
            handleJoin(context);
          },
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
              "Join Event",
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

  void handleJoin(BuildContext c) {
    var alert = AlertDialog(
      title: Text("Join ${widget.eventDetails.eventName}"),
      content: Text("Are you sure you want to joi this event?!"),
      actions: [
        TextButton(
          onPressed: () {
            _joinUserEvent();
            Navigator.pushNamed(c, "/homeScreen");
          },
          child: Text("OK"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(c);
          },
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: c,
        builder: (context) {
          return alert;
        });
  }

  final User? usr = Auth().auth.currentUser;
  String dateJoined = DateTime.now().toString();

  Future<void> _joinUserEvent() async {
    final DatabaseReference userEventsRef =
        FirebaseDatabase.instance.ref().child('userEvents');
    UserDetails? userData = await FirebaseService().getUserDetails(usr!.uid);
    var eventObj = UserEventDetails(
      eID: '${widget.eventDetails.eventID}',
      stID: '${userData!.studentId}',
      dateJoined: '$dateJoined',
    );

    userEventsRef.push().set(eventObj.toMap()).then((_) {
      print('****************************************');
      print('Joined event successfully!');
      print('****************************************');
      Navigator.pushNamed(context, '/homeScreen');
    }).catchError((error) {
      print('Failed to add event: $error');
    });
  }
}
