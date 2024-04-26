import 'package:flutter/material.dart';
import 'package:community_service/widgets/drawer.dart';
import 'package:community_service/widgets/tracker.dart';
import 'package:community_service/widgets/insights.dart';
import 'package:community_service/widgets/eventSummary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  TrackerWidget(
                    icon: Icon(
                      Icons.control_point_duplicate_outlined,
                      color: Color(0xFF144E73),
                    ),
                    count: 10,
                    subtitle: "Points",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  TrackerWidget(
                    icon: Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF144E73),
                    ),
                    count: 8,
                    subtitle: "Rank",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("Insights"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                InsightWidget(),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: Color(0x15000000),
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0x30144E73),
                    ),
                    width: MediaQuery.of(context).size.width * .5 - 20,
                    child: Center(
                        child: Text(
                      "Current Events",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    width: MediaQuery.of(context).size.width * .5 - 20,
                    child: Center(
                        child: Text(
                      "Past Events",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventSummaryWidget(),
                EventSummaryWidget(),
                EventSummaryWidget(),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
