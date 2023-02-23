import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:dental_clinic/components/profile_textfield.dart';
import 'package:dental_clinic/api.dart';
import 'package:mysql_utils/mysql1/mysql1.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Profile'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Treatment'),
                ),
              ],
            ),
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: AssetImage('images/apple.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileTextField(text: '${user.user}'),
            ProfileTextField(text: '${user.fullname}'),
            ProfileTextField(text: '${user.email}'),
            ProfileTextField(text: '${user.idcard}'),
            ProfileTextField(text: '${user.birthdate}'),
            ProfileTextField(text: '${user.phone}'),
            ProfileTextStringField(text: '${user.disease}'),
            ProfileTextStringField(text: '${user.allergy}'),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final int userId;

  ProfileScreen({required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final conn = await MySqlConnection.connect(getConnectionSettings());
    final results =
        await conn.query('SELECT * FROM user WHERE id = ?', [widget.userId]);
    if (results.isNotEmpty) {
      final row = results.first;
      setState(
        () {
          user = User(
            id: row['id'],
            user: row['username'],
            email: row['email'],
            fullname: row['fullname'],
            idcard: row['idcard'],
            birthdate: row['birthdate'],
            phone: row['phone'],
            disease: row['disease'],
            allergy: row['allergy'],

            // ... other user data fields
          );
        },
      );
    }
    await conn.close();
  }

  Widget build(BuildContext context) {
    if (user == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ProfilePage(user: user!);
    }
  }
}
