import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/home_cards_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                          child: TextBold(
                              text: 'BeePet',
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      HomeCardWidget(
                          icon: Icons.account_circle, title: 'Profile'),
                      HomeCardWidget(icon: Icons.pets, title: 'My Pets'),
                      HomeCardWidget(
                          icon: Icons.qr_code_scanner_rounded,
                          title: 'Scan QR Code'),
                      HomeCardWidget(
                          icon: Icons.notifications, title: 'Notifications'),
                      HomeCardWidget(icon: Icons.forum, title: 'Pet Community'),
                      HomeCardWidget(
                          icon: Icons.medical_services,
                          title: 'Pet Medical Record'),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ButtonWidget(
                          fontColor: Colors.black,
                          width: 150,
                          color: Colors.white,
                          label: 'Logout',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: TextBold(
                                          text: 'Logout Confirmation',
                                          color: Colors.black,
                                          fontSize: 14),
                                      content: TextRegular(
                                          text:
                                              'Are you sure you want to logout?',
                                          color: Colors.black,
                                          fontSize: 16),
                                      actions: <Widget>[
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: TextBold(
                                              text: 'Close',
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                        MaterialButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                          },
                                          child: TextBold(
                                              text: 'Continue',
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ));
                          }),
                    ),
                  ),
                  Container(
                    color: primary,
                    width: double.infinity,
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
