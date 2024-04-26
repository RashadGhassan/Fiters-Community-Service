import 'package:flutter/material.dart';

class EventSummaryWidget extends StatefulWidget {
  const EventSummaryWidget({super.key});

  @override
  State<EventSummaryWidget> createState() => _EventSummaryWidgetState();
}

class _EventSummaryWidgetState extends State<EventSummaryWidget> {
  @override
  Widget build(BuildContext context) {
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
                      "LinkedIn Workshop",
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
                          "1G04",
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
                          "02/05/2024",
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
                          "11:00 am - 12:00 pm",
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
