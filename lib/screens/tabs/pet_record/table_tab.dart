import 'package:beepet/utils/colors.dart';
import 'package:beepet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TableTab extends StatelessWidget {
  const TableTab({super.key});

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
                                  text: 'Pet Medical History',
                                  fontSize: 24,
                                  color: Colors.white),
                              const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                  text: 'PRIC',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ], rows: [
                              for (int i = 0; i < 10; i++)
                                DataRow(cells: [
                                  DataCell(
                                    TextRegular(
                                        text: 'Sample',
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sample',
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sample',
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sample',
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Sample',
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                ])
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
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
