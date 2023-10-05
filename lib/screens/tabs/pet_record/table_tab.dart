import 'package:beepet/services/add_record.dart';
import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:beepet/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableTab extends StatefulWidget {
  var data;

  TableTab({super.key, required this.data});

  @override
  State<TableTab> createState() => _TableTabState();
}

class _TableTabState extends State<TableTab> {
  final diseaseController = TextEditingController();
  final treatmentController = TextEditingController();
  final medicineController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: solid,
        onPressed: () {
          addRecord(context);
        },
        child: const Icon(Icons.add),
      ),
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
                                  text: 'Pet Medical History',
                                  fontSize: 24,
                                  color: Colors.white),
                              const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Records')
                              .where('petid', isEqualTo: widget.data.id)
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
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Card(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(columns: [
                                    DataColumn(
                                      label: TextBold(
                                        text: 'Date',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextBold(
                                        text: 'Disease',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextBold(
                                        text: 'Treatment',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextBold(
                                        text: 'Medicine',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextBold(
                                        text: 'Price',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ], rows: [
                                    for (int i = 0; i < data.docs.length; i++)
                                      DataRow(cells: [
                                        DataCell(
                                          TextRegular(
                                              text: DateFormat.yMMMd()
                                                  .add_jm()
                                                  .format(data.docs[i]
                                                          ['dateTime']
                                                      .toDate()),
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        DataCell(
                                          TextRegular(
                                              text: data.docs[i]['disease'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        DataCell(
                                          TextRegular(
                                              text: data.docs[i]['treatment'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        DataCell(
                                          TextRegular(
                                              text: data.docs[i]['medicine'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        DataCell(
                                          TextRegular(
                                              text: data.docs[i]['pric'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ])
                                  ]),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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

  addRecord(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primary,
          title: TextBold(
              text: 'Adding a pet record', fontSize: 18, color: Colors.white),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldWidget(
                    label: 'Disease', controller: diseaseController),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    label: 'Treatment', controller: treatmentController),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    label: 'Medicine', controller: medicineController),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    inputType: TextInputType.number,
                    label: 'Price',
                    controller: priceController),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    TextBold(text: 'Close', fontSize: 14, color: Colors.white)),
            TextButton(
                onPressed: () {
                  addMedicalRecord(
                      widget.data['name'],
                      diseaseController.text,
                      treatmentController.text,
                      medicineController.text,
                      priceController.text,
                      widget.data.id);
                  Navigator.pop(context);
                },
                child:
                    TextBold(text: 'Save', fontSize: 14, color: Colors.white))
          ],
        );
      },
    );
  }
}
