import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Dentist_Information extends StatefulWidget {
  const Dentist_Information({super.key});

  @override
  State<Dentist_Information> createState() => _Dentist_InformationState();
}

class _Dentist_InformationState extends State<Dentist_Information> {
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

    final results = await conn.query('SELECT * FROM dentist');
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['prefix'] +
                          ' ' +
                          item['first_name'] +
                          ' ' +
                          item['last_name'],
                    )
                  ],
                ),
                Text(
                  item['email'],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
