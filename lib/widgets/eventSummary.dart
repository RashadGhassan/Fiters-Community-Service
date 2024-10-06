import 'dart:async';
import 'package:community_service/screens/eventAttendanceDescriptionScreen.dart';
import 'package:flutter/material.dart';
import '../models/event_details.dart';
import '../models/firebase_service.dart';
import '../models/user_event_details.dart';

class EventSummaryWidget extends StatefulWidget {
  final UserEventDetails userEventDetails;
  const EventSummaryWidget({super.key, required this.userEventDetails});

  @override
  State<EventSummaryWidget> createState() => _EventSummaryWidgetState();
}

class _EventSummaryWidgetState extends State<EventSummaryWidget> {
  EventDetails? eventDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData(); // Fetch the data when the widget is created
  }

  Future<void> getData() async {
    try {
      eventDetails = await FirebaseService()
          .getProductDetailsByEventId(widget.userEventDetails.eID);
      ; // Fetch and store data
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false; // Update the loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("=============================");
    if (isLoading) {
      return CircularProgressIndicator();
    } else if (eventDetails == null) {
      return Text('Error or no data available');
    } else {
      print("=============================");
      print(eventDetails!.eventID);
      print(eventDetails!.eventName);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Color(0x15000000),
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: Colors.white,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${eventDetails!.eventName}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          size: 16,
                          color: Color(0xff8A8B8B),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${eventDetails!.eventLocation}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff8A8B8B),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Color(0xff8A8B8B),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${eventDetails!.eventDate}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff8A8B8B),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm_outlined,
                          size: 16,
                          color: Color(0xff8A8B8B),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${eventDetails!.eventTiming}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff8A8B8B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xff8A8B8B),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventAttendance(
                          eventDetails: eventDetails!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
