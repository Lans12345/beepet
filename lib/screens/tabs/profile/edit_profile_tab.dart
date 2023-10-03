import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/button_widget.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:beepet/widgets/textfield_widget.dart';
import 'package:beepet/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileTab extends StatefulWidget {
  String? id;

  EditProfileTab({
    super.key,
    required this.id,
  });

  @override
  State<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends State<EditProfileTab> {
  final nameController = TextEditingController();

  final contactController = TextEditingController();

  final addressController = TextEditingController();

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
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                leading:
                                                    const Icon(Icons.camera),
                                                title: TextRegular(
                                                    text: 'Camera',
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              const Divider(),
                                              ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                leading:
                                                    const Icon(Icons.image),
                                                title: TextRegular(
                                                    text: 'Gallery',
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.account_circle_outlined,
                                  size: 32,
                                ),
                              ),
                            ),
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
              TextFieldWidget(
                  labelColor: Colors.black,
                  label: 'Name',
                  controller: nameController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  labelColor: Colors.black,
                  label: 'Contact Number',
                  controller: contactController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  labelColor: Colors.black,
                  label: 'Address',
                  controller: addressController),
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
                      label: 'SAVE',
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.id)
                            .update({
                          'username': nameController.text,
                          'contactNumber': contactController.text,
                          'address': addressController.text
                        });
                        Navigator.pop(context);
                        showToast('Profile updated succesfully!');
                      }),
                ),
              ),
              const Expanded(child: SizedBox()),
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
