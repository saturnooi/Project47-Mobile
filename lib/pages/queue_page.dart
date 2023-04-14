import 'package:flutter/material.dart';
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
        'SELECT * FROM appointment WHERE patient_id = @patient_id',
        substitutionValues: {'patient_id': widget.userId});
    setState(() {
      _data = results.map((row) => row.toColumnMap()).toList();
    });

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
      '10.0.2.2',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
    );

    await _connection.open();
  }

  Future<void> _confirmAppointment() async {
    await _connection.query(
      'UPDATE appointment SET status = @status WHERE patient_id = @patient_id AND status = @status_old ',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยืนยัน',
        'status_old': 'รอการยืนยันจากคนไข้',
      },
    );
  }

  Future<void> _cancelAppointment() async {
    await _connection.query(
      'UPDATE appointment SET status = @status WHERE patient_id = @patient_id AND status = @status_old',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยืนยัน',
        'status_old': 'รอการยืนยันจากคนไข้',
      },
    );
  }

  Future<void> _cancel2Appointment() async {
    await _connection.query(
      'UPDATE appointment SET status = @status WHERE patient_id = @patient_id AND status = @status_old',
      substitutionValues: {
        'patient_id': widget.userId,
        'status': 'ยกเลิก',
        'status_old': 'รอการยืนยันจากคลินิก',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          final date = DateTime.parse(item['date_appoint'].toString());
          final day = DateFormat.d().format(date);
          final month = DateFormat.MMM().format(date);
          final year = DateFormat.y().format(date);
          // String showTime = "เวลา = $item[time_appoint']";
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Text("วันที่"),
                  const SizedBox(width: 5),
                  Text(day),
                  const SizedBox(width: 5),
                  Text(month),
                  const SizedBox(width: 5),
                  Text(year),
                  item['status'] == 'รอการยืนยันจากคลินิก' ||
                          item['status'] == 'ยืนยัน' ||
                          item['status'] == 'ยกเลิก'
                      ? item['status'] == 'ยกเลิก'
                          ? SizedBox()
                          : OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('ต้องการยกเลิกหรือไม่'),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              _cancel2Appointment();
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
                                            child: Text('ตกลง'),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('ไม่ต้องการ'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text('ยกเลิก'),
                            )
                      : Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                _confirmAppointment();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Mainpage(
                                      userId: widget.userId,
                                    ),
                                  ),
                                );
                              },
                              child: Text('ยืนยัน'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ต้องการยกเลิกหรือไม่'),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              _cancelAppointment();
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
                                            child: const Text('ไม่ต้องการ'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text('ยกเลิก'),
                            )
                          ],
                        ),
                ],
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 21),
                      Text('สถานะ :'),
                      const SizedBox(width: 5),
                      Text(item['status']),
                    ],
                  ),
                  Row(
                    children: [
                      Text('ทันตแพทย์ :'),
                      const SizedBox(width: 5),
                      item['dentist_id'] == null
                          ? Text('ยังไม่มี')
                          : Text('มีแล้ว'),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 22),
                      Text('อาการ :'),
                      const SizedBox(width: 5),
                      Text(item['symtom']),
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
