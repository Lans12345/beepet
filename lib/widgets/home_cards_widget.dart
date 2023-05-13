import 'package:flutter/material.dart';

import 'text_widget.dart';

class HomeCardWidget extends StatelessWidget {
  IconData icon;
  String title;

  HomeCardWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 5, top: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(
              icon,
              size: 38,
              color: Colors.black,
            ),
            title: TextBold(text: title, fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
