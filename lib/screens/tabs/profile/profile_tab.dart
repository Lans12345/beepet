import 'package:beepet/screens/tabs/profile/edit_profile_tab.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileTab extends StatefulWidget {
  String? username;

  ProfileTab({super.key, this.username = ''});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

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
          child: StreamBuilder<QuerySnapshot>(
              stream: widget.username != ''
                  ? FirebaseFirestore.instance
                      .collection('Users')
                      .where('username', isEqualTo: widget.username)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('Users')
                      .where('username', isEqualTo: box.read('username'))
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;

                return Column(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 75),
                          child: Center(
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    minRadius: 35,
                                    maxRadius: 35,
                                    backgroundImage:
                                        NetworkImage(data.docs[0]['profile']),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextBold(
                                      text: 'Name: ${data.docs[0]['username']}',
                                      fontSize: 14,
                                      color: solid),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextBold(
                                      text:
                                          'Contact No.: ${data.docs[0]['contactNumber']}',
                                      fontSize: 12,
                                      color: solid),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextBold(
                                      text:
                                          'Location: ${data.docs[0]['address']}',
                                      fontSize: 12,
                                      color: solid),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ButtonWidget(
                            fontSize: 16,
                            fontColor: solid,
                            width: 100,
                            height: 35,
                            color: Colors.white,
                            label: 'EDIT',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfileTab(
                                        id: data.docs[0].id,
                                      )));
                            }),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: widget.username != ''
                            ? FirebaseFirestore.instance
                                .collection('Users')
                                .where('username', isEqualTo: widget.username)
                                .snapshots()
                            : FirebaseFirestore.instance
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
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, right: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: ButtonWidget(
                                  fontSize: 16,
                                  fontColor: solid,
                                  width: 100,
                                  height: 35,
                                  color: Colors.white,
                                  label: 'View QR Code',
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
                                  }),
                            ),
                          );
                        }),
                    const Expanded(child: SizedBox()),
                    Container(
                      color: primary,
                      width: double.infinity,
                      height: 20,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
