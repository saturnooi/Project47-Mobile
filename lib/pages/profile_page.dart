import 'package:flutter/material.dart';
import 'package:dental_clinic/components/profile_textfield.dart';
import 'package:dental_clinic/api.dart';
import 'package:dental_clinic/pages/history.dart';
import 'package:postgres/postgres.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> _userData = {};

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
      'SELECT * FROM patient WHERE id = @id',
      substitutionValues: {'id': widget.userId},
    );
    if (results.isNotEmpty) {
      setState(() {
        _userData = results.first.toColumnMap();
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            color: Color.fromARGB(255, 173, 157, 14),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: _userData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Text('Profile'),
                      // ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryPage(
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Treatment',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage('images/nat.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ProfileTextField(text: _userData['username']),
                  // const SizedBox(height: 10),
                  ProfileTextField(text: _userData['email']),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ProfileTextFieldNamePrefix(text: _userData['prefix']),
                      ProfileTextFieldName(text: _userData['first_name']),
                      ProfileTextFieldName(text: _userData['last_name']),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['card_id']),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['tel']),
                  const SizedBox(height: 10),
                  ProfileTextStringField(text: _userData['allergy']),
                  const SizedBox(height: 10),
                  ProfileTextStringField(text: _userData['underlying_disease']),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
