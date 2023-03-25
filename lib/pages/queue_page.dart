import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';

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
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
      // useSSL: true,
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
                              onPressed: () {},
                              child: Text('ยกเลิก'),
                            )
                      : Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('ยืนยัน'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
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
