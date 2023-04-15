import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/api.dart';

class DisplayDataScreen extends StatefulWidget {
  @override
  _DisplayDataScreenState createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
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

    final results = await conn.query('SELECT * FROM blog');
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
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(item['topic']),
                  subtitle: Text(item['content']),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Read more>>",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
