import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrackerWidget extends StatefulWidget {
  TrackerWidget(
      {super.key,
      required this.icon,
      required this.count,
      required this.subtitle});
  Icon icon;
  int count;
  String subtitle;

  @override
  State<TrackerWidget> createState() => _TrackerWidgetState();
}

class _TrackerWidgetState extends State<TrackerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: MediaQuery.of(context).size.width * 0.48 - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Color(0x15000000),
            spreadRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0x30144E73),
            ),
            child: widget.icon,
          ),
          Container(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.count}",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF144E73),
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF144E73),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
