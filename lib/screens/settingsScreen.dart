import 'package:flutter/material.dart';
import 'package:community_service/widgets/drawer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: const Options(),
    );
  }
}

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("Appearance (Light & Dark)"),
        ),
        const ListTile(
          title: Text("Notifications"),
        ),
        ListTile(
          title: const Text("Profile"),
          onTap: () {
            Navigator.pushNamed(context, "/profileScreen");
          },
        ),
        const ListTile(
          title: Text("Help & Feedback"),
        ),
        const ListTile(
          title: Text("What's New"),
        ),
        const ListTile(
          title: Text("About"),
        ),
        ListTile(
          title: const Text("Sign Out"),
          onTap: () {
            Navigator.pushNamed(context, "/signInScreen");
          },
        ),
      ],
    );
  }
}
