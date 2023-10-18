import 'package:beepet/services/add_msg.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PetCommunityTabAdmin extends StatefulWidget {
  const PetCommunityTabAdmin({super.key});

  @override
  State<PetCommunityTabAdmin> createState() => _PetCommunityTabAdminState();
}

class _PetCommunityTabAdminState extends State<PetCommunityTabAdmin> {
  final msgController = TextEditingController();

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: TextBold(
                      text: 'Type a message',
                      fontSize: 18,
                      color: Colors.black),
                  content: TextFormField(
                    controller: msgController,
                    decoration: InputDecoration(
                        suffixIcon: StreamBuilder<QuerySnapshot>(
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
                              return IconButton(
                                onPressed: () async {
                                  addMessage(msgController.text, 'Admin');
                                  Navigator.pop(context);
                                  msgController.clear();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: primary,
                                ),
                              );
                            }),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                );
              },
            );
          }),
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
                              const SizedBox(
                                width: 50,
                              ),
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Messages')
                      .orderBy('dateTime', descending: true)
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
                    return SizedBox(
                      height: 550,
                      child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 125,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextBold(
                                            text: data.docs[index]['myname'],
                                            fontSize: 14,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextRegular(
                                            text: data.docs[index]['desc'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                                size: 15,
                                              ),
                                              label: TextRegular(
                                                  text: 'Comment',
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.report,
                                                color: Colors.grey,
                                                size: 15,
                                              ),
                                              label: TextRegular(
                                                  text: 'Report from Clinic',
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    );
                  }),
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
