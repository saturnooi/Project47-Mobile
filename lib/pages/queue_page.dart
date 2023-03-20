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
      substitutionValues: {'patient_id': widget.userId},
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
          final date = DateTime.parse(item['date_appoint'].toString());
          final day = DateFormat.d().format(date);
          final month = DateFormat.MMM().format(date);
          final year = DateFormat.y().format(date);
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Text("วันที่"),
                  Text(day),
                  const SizedBox(width: 5),
                  Text(month),
                  const SizedBox(width: 5),
                  Text(year),
                  Text("เวลา"),
                ],
              ),
              subtitle: Text(item['symtom']),
            ),
          );
        },
      ),
    );
  }
}
