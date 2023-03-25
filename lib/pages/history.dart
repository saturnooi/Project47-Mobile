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
      'SELECT * FROM history_appointment WHERE patient_id = @patient_id',
    );
    setState(() {
      _data = results.map((row) => row.toColumnMap()).toList();
    });

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
            child: ListTile(
              title: Row(
                children: [
                  Text(item['detail']),
                  // Text("วันที่"),
                  // const SizedBox(width: 5),
                  // Text(day),
                  // const SizedBox(width: 5),
                  // Text(month),
                  // const SizedBox(width: 5),
                  // Text(year),
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
                          child: Text('รีวิว'),
                        )
                      : SizedBox(),
                ],
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text('คำเนะนำ :'),
                      const SizedBox(width: 5),
                      Text(item['advise']),
                    ],
                  ),
                  Row(
                    children: [
                      Text('รีวิว :'),
                      const SizedBox(width: 5),
                      (item['confirm_review']) == 0
                          ? Text('ยังไม่ได้รีวิว')
                          : Text('เสร็จเรียบร้อย')
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
