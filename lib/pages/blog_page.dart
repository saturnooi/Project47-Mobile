import 'package:flutter/material.dart';
import 'package:mysql_utils/mysql1/mysql1.dart';
import 'package:dental_clinic/api.dart';

class DisplayDataScreen extends StatefulWidget {
  @override
  _DisplayDataScreenState createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
  final List<Map<String, dynamic>> _dataList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    final conn = await MySqlConnection.connect(getConnectionSettings());
    var results = await conn.query('SELECT * FROM news');
    results.forEach((row) {
      setState(() {
        _dataList.add(row.fields);
      });
    });
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_left),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_dataList[index]['topic']),
                    subtitle: Text(_dataList[index]['detail'].toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
