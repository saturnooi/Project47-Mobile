import 'package:dental_clinic/pages/review_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/pages/review_write.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _data = [];
  Map<String, dynamic> _dentistData = {};

  Future<void> _fetchData() async {
    final conn = PostgreSQLConnection(
      'db-postgresql-sgp1-56608-do-user-12968204-0.b.db.ondigitalocean.com',
      25060,
      'defaultdb',
      username: 'doadmin',
      password: 'AVNS_bXQmx_V8B3bMS_Dhhh2',
      useSSL: true,
    );
    await conn.open();

    final results = await conn.query(
        'SELECT * FROM history_appointment WHERE patient_id = @patient_id',
        substitutionValues: {'patient_id': widget.userId});

    setState(() {
      _data = results.map((row) => row.toColumnMap()).toList();
    });

    await conn.close();
  }

  Future<void> _dentist_name(int dentist_id) async {
    final conn = PostgreSQLConnection(
      'db-postgresql-sgp1-56608-do-user-12968204-0.b.db.ondigitalocean.com',
      25060,
      'defaultdb',
      username: 'doadmin',
      password: 'AVNS_bXQmx_V8B3bMS_Dhhh2',
      useSSL: true,
    );
    await conn.open();

    final results = await conn.query(
        'SELECT * FROM dentist WHERE id = @dentist_id',
        substitutionValues: {'dentist_id': dentist_id});

    if (results.isNotEmpty) {
      setState(() {
        _dentistData = results.first.toColumnMap();
      });
    }

    await conn.close();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          // final date = DateTime.parse(item['date_appoint'].toString());
          // final day = DateFormat.d().format(date);
          // final month = DateFormat.MMM().format(date);
          // final year = DateFormat.y().format(date);
          // String showTime = "เวลา = $item[time_appoint']";

          return Card(
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actions: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.grey,
                          ),
                        ),
                      ],
                      content: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'อาการ : ',
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                item['detail'],
                                style: const TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('แพทย์ผู้ดูแล : '),
                              FutureBuilder<void>(
                                future: _dentist_name(
                                  item['dentist_id'],
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Text(_dentistData['prefix'] +
                                        ' ' +
                                        _dentistData['first_name'] +
                                        ' ' +
                                        _dentistData['last_name']);
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: SizedBox(
                              height: 150, // Set the height of the SizedBox
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      8.0), // Set padding for the Container
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['advise'],
                                      textAlign: TextAlign
                                          .justify, // Align the text to justify
                                      style: const TextStyle(
                                          fontSize:
                                              16), // Set the font size of the text
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'อาการ : ' + item['detail'],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      (item['confirm_review']) == 0
                          ? OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewWrite(
                                      userId: item['patient_id'],
                                      detail: item['detail'],
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'รีวิว',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 170, 154, 4)),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'แพทย์ผู้ดูแล : ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Click for more infomation',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            // child: ListTile(
            //   title: Row(
            //     children: [
            //       Text(item['detail']),
            //       // Text("วันที่"),
            //       // const SizedBox(width: 5),
            //       // Text(day),
            //       // const SizedBox(width: 5),
            //       // Text(month),
            //       // const SizedBox(width: 5),
            //       // Text(year),
            //       (item['confirm_review']) == 0
            //           ? OutlinedButton(
            //               onPressed: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => ReviewWrite(
            //                       userId: item['patient_id'],
            //                       detail: item['detail'],
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Text('รีวิว'),
            //             )
            //           : SizedBox(),
            //     ],
            //   ),
            //   subtitle: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Text('คำเนะนำ :'),
            //           const SizedBox(width: 5),
            //           Text(item['advise']),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Text('รีวิว :'),
            //           const SizedBox(width: 5),
            //           (item['confirm_review']) == 0
            //               ? Text('ยังไม่ได้รีวิว')
            //               : Text('เสร็จเรียบร้อย')
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
