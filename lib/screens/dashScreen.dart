import 'package:community_service/models/user_auth.dart';
import 'package:community_service/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:community_service/widgets/drawer.dart';
import 'package:community_service/widgets/tracker.dart';
// import 'package:community_service/widgets/insights.dart';
import 'package:community_service/widgets/eventSummary.dart';

import '../models/firebase_service.dart';
import '../models/user_event_details.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var user = FirebaseService().getUserDetails(Auth().auth.currentUser!.uid);

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
      body: Column(
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
                    ),
                  ),
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
          Flexible(
            child: Container(
              // height: MediaQuery.of(context).size.height / 1.5,
              child: FutureBuilder(
                future: FirebaseService().getUserEventDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<UserEventDetails> elist = snapshot.data!;
                    return ListView.builder(
                      itemCount: elist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EventSummaryWidget(
                          userEventDetails: elist[index],
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      // Container(
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      //   child: Row(
      //     children: [
      //       TrackerWidget(
      //         icon: Icon(
      //           Icons.control_point_duplicate_outlined,
      //           color: Color(0xFF144E73),
      //         ),
      //         count: 10,
      //         subtitle: "Points",
      //       ),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width * 0.04,
      //       ),
      //       TrackerWidget(
      //         icon: Icon(
      //           Icons.auto_awesome,
      //           color: Color(0xFF144E73),
      //         ),
      //         count: 8,
      //         subtitle: "Rank",
      //       ),
      //     ],
      //   ),
      // ),
      //       // todo insight graph
      //       // const SizedBox(
      //       //   height: 12,
      //       // ),
      //       // Column(
      //       //   crossAxisAlignment: CrossAxisAlignment.start,
      //       //   children: [
      //       //     Padding(
      //       //       padding: const EdgeInsets.symmetric(horizontal: 20),
      //       //       child: Row(
      //       //         children: [
      //       //           Text("Insights"),
      //       //         ],
      //       //       ),
      //       //     ),
      //       //     const SizedBox(
      //       //       height: 4,
      //       //     ),
      //       //     InsightWidget(),
      //       //   ],
      //       // ),
      // const SizedBox(
      //   height: 12,
      // ),
      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 20),
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 30,
      //         color: Color(0x15000000),
      //         spreadRadius: 5,
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Container(
      //         padding: EdgeInsets.symmetric(vertical: 8),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(100),
      //           color: Color(0x30144E73),
      //         ),
      //         width: MediaQuery.of(context).size.width * .5 - 20,
      //         child: Center(
      //           child: Text(
      //             "Current Events",
      //             style: TextStyle(
      //               fontSize: 16,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.symmetric(vertical: 8),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(100),
      //         ),
      //         width: MediaQuery.of(context).size.width * .5 - 20,
      //         child: Center(
      //             child: Text(
      //           "Past Events",
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         )),
      //       ),
      //     ],
      //   ),
      // ),
      // const SizedBox(
      //   height: 12,
      // ),
      //       Container(
      //         child: FutureBuilder(
      //           future: FirebaseService().getUserEventDetails(),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               List<UserEventDetails> elist = snapshot.data!;
      //               return ListView.builder(
      //                 itemCount: elist.length,
      //                 itemBuilder: (BuildContext context, int index) {
      //                   print("####################${elist[index]}")
      //                   return EventSummaryWidget(
      //                     userEventDetails: elist[index],
      //                   );
      //                 },
      //               );
      //             } else {
      //               return const Center(child: CircularProgressIndicator());
      //             }
      //           },
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 12,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
