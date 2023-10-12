import 'package:beepet/screens/tabs/my_pets/my_pets_tab.dart';
import 'package:beepet/screens/tabs/notif_tab.dart';
import 'package:beepet/screens/tabs/pet_community_tab.dart';
import 'package:beepet/screens/tabs/pet_record/main_screen.dart';
import 'package:beepet/screens/tabs/profile/profile_tab.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/home_cards_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/toast_widget.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();

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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProfileTab()));
                          },
                          icon: Icons.account_circle,
                          title: 'Profile'),
                      HomeCardWidget(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyPetsTab()));
                          },
                          icon: Icons.pets,
                          title: 'My Pets'),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('username',
                                  isEqualTo: box.read('username'))
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print('error');
                              return const Center(child: Text('Error'));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              );
                            }

                            final data = snapshot.requireData;
                            return HomeCardWidget(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: TextBold(
                                              text: 'Your QR Code',
                                              fontSize: 18,
                                              color: Colors.black),
                                          content: SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: QrImageView(
                                              data: data.docs[0].id,
                                              version: QrVersions.auto,
                                              size: 200.0,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: (() {
                                                  Navigator.pop(context);
                                                }),
                                                child: TextBold(
                                                    text: 'Close',
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                          ],
                                        );
                                      }));
                                },
                                icon: Icons.qr_code_scanner_rounded,
                                title: 'Scan QR Code');
                          }),
                      HomeCardWidget(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const NotifTab()));
                          },
                          icon: Icons.notifications,
                          title: 'Notifications'),
                      HomeCardWidget(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PetCommunityTab()));
                          },
                          icon: Icons.forum,
                          title: 'Pet Community'),
                      HomeCardWidget(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const MainPetRecordTab()));
                          },
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
                                            showToast(
                                                'Logged out succesfully!');
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
