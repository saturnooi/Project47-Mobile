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
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
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
        title: Text('Profile'),
      ),
      body: _userData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Profile'),
                      ),
                      ElevatedButton(
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
                        child: Text('Treatment'),
                      ),
                    ],
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
                  ProfileTextField(text: _userData['username']),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['email']),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['fullname']),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['id_card']),
                  const SizedBox(height: 10),
                  ProfileTextField(text: _userData['phone_number']),
                  const SizedBox(height: 10),
                  ProfileTextStringField(text: _userData['drug_allergy']),
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
