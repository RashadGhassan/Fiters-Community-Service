// import 'package:community_service/main.dart';
import 'package:community_service/models/event_details.dart';
import 'package:flutter/material.dart';
import 'package:community_service/screens/eventDescriptionScreen.dart';

class EventCard extends StatelessWidget {
  final EventDetails eventDetails;
  EventCard({super.key, required this.eventDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/eventDescriptionScreen");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDescription(
              eventDetails: eventDetails,
            ),
          ),
        );
      },
      child: Container(
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
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 165,
                    width: double.infinity,
                    child: Image.network(
                      "${eventDetails.evenImageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 8, right: 120, bottom: 16),
                    width: double.infinity,
                    color: Colors.white,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${eventDetails.eventName}",
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
                                "${eventDetails.eventLocation}",
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
                                "${eventDetails.eventDate}",
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
                                "${eventDetails.eventTiming}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff8A8B8B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                heightFactor: 2.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                          strokeAlign: 0,
                        ),
                      ),
                      child: Image.network(
                        "${eventDetails.organizerPic}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
