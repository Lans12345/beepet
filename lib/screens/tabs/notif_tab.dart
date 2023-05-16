import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotifTab extends StatelessWidget {
  const NotifTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back1.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.teal[300],
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              TextBold(
                                  text: 'BeePet',
                                  fontSize: 24,
                                  color: Colors.white),
                              const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.mail,
                            color: primary,
                          ),
                          title: TextBold(
                              text: 'Succesfully registered!',
                              fontSize: 14,
                              color: Colors.black),
                          subtitle: TextRegular(
                              text: 'January 01, 2023',
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Container(
                color: primary,
                width: double.infinity,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
