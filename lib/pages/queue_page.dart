import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/pages/main_page.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
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
        'SELECT * FROM queue WHERE "patientId" = @patient_id',
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
  // Future<void> _dentistName() async {
  //   await _connection.query('select fullname from dentist where id = @id',
  //       substitutionValues: {});
  // }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _connectToDatabase();
  }

  late PostgreSQLConnection _connection;

  Future<void> _connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'db-postgresql-sgp1-56608-do-user-12968204-0.b.db.ondigitalocean.com',
      25060,
      'defaultdb',
      username: 'doadmin',
      password: 'AVNS_bXQmx_V8B3bMS_Dhhh2',
      useSSL: true,
    );

    await _connection.open();
  }

  Future<void> _confirmAppointment(int appoint_id) async {
    await _connection.query(
      'UPDATE queue SET status = @status WHERE "patientId" = @patient_id AND id = @appoint_id ',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยืนยัน',
        'appoint_id': appoint_id,
      },
    );
  }

  Future<void> _cancelAppointment(int appoint_id) async {
    await _connection.query(
      'UPDATE queue SET status = @status WHERE "patientId" = @patient_id AND id = @appoint_id',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยกเลิก',
        'appoint_id': appoint_id,
      },
    );
  }

  Future<void> _cancel2Appointment(int appoint_id) async {
    await _connection.query(
      'UPDATE queue SET status = @status WHERE "patientId" = @patient_id AND id = @appoint_id',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยกเลิก',
        'appoint_id': appoint_id,
      },
    );
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
          final date = DateTime.parse(item['time_start'].toString());
          final day = DateFormat.d().format(date);
          final String month = DateFormat.MMM().format(date);
          final year = DateFormat.y().format(date);
          final hour = DateFormat.Hm().format(date);
          final int thaiyear = int.parse(year) + 543;
          final String thaiYearString = thaiyear.toString();

          final Map<String, String> englishToThaiMonths = {
            'Jan': 'มกราคม',
            'Feb': 'กุมภาพันธ์',
            'Mar': 'มีนาคม',
            'Apr': 'เมษายน',
            'May': 'พฤษภาคม',
            'Jun': 'มิถุนายน',
            'Jul': 'กรกฎาคม',
            'Aug': 'สิงหาคม',
            'Sep': 'กันยายน',
            'Oct': 'ตุลาคม',
            'Nov': 'พฤศจิกายน',
            'Dec': 'ธันวาคม',
          };
          final Map<String, String> englishToThaiMonths2 = {
            'Jan': 'ม.ค.',
            'Feb': 'ก.พ.',
            'Mar': 'มี.ค.',
            'Apr': 'เม.ย.',
            'May': 'พ.ค.',
            'Jun': 'มิ.ย.',
            'Jul': 'ก.ค.',
            'Aug': 'ส.ค.',
            'Sep': 'ก.ย.',
            'Oct': 'ต.ค.',
            'Nov': 'พ.ย.',
            'Dec': 'ธ.ค.',
          };
          final String? thaiMonth = englishToThaiMonths[month];
          final String? thaiMonth2 = englishToThaiMonths2[month];
          print(item['time_start'].runtimeType);
          String showTime = "เวลา = $item[time_start']";

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
                            icon: const Icon(Icons.close),
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
                              Text(
                                "วันที่" +
                                    ' ' +
                                    day +
                                    ' ' +
                                    thaiMonth.toString() +
                                    ' ' +
                                    thaiYearString,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'เวลาเริ่ม : ' + hour,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text('แพทย์ผู้ดูแล : '),
                              item['dentistId'] == null
                                  ? const SizedBox()
                                  : FutureBuilder<void>(
                                      future: _dentist_name(
                                        item['dentistId'],
                                      ),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<void> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Text(_dentistData['prefix'] +
                                              " " +
                                              _dentistData['first_name'] +
                                              " " +
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
                                      item['symtom'],
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
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text('สถานะ : '),
                              Text(
                                item['status'],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันที่" +
                            ' ' +
                            day +
                            ' ' +
                            thaiMonth2.toString() +
                            ' ' +
                            thaiYearString,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 5),
                      item['status'] == 'รอการยืนยันจากคลินิก' ||
                              item['status'] == 'รอพบทันตแพทย์' ||
                              item['status'] == 'ยกเลิก'
                          ? item['status'] == 'ยกเลิก'
                              ? const SizedBox()
                              : OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'ต้องการยกเลิกหรือไม่'),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  _cancel2Appointment(
                                                      item['id']);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Mainpage(
                                                        userId: widget.userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text('ตกลง'),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'ไม่ต้องการ',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                          : Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _confirmAppointment(item['id']);

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Mainpage(
                                          userId: widget.userId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'ยืนยัน',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'ต้องการยกเลิกหรือไม่'),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  _cancelAppointment(
                                                      item['id']);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Mainpage(
                                                        userId: widget.userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text('ตกลง'),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'ไม่ต้องการ',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '    เวลาเริ่ม  : ' + hour,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 21),
                          Text(
                            'สถานะ  :' + '  ' + item['status'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'ทันตแพทย์ :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          item['dentistId'] == null
                              ? const Text(
                                  'ยังไม่มี',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                  ),
                                )
                              : const Text(
                                  'มีแล้ว',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 22),
                          Text(
                            'อาการ   :' + '  ' + item['symtom'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
