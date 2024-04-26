import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.navigateTo,
  });
  final String title;
  final Icon icon;
  final String navigateTo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, navigateTo);
      },
    );
  }
}
