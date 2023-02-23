import 'package:mysql_utils/mysql1/mysql1.dart';

ConnectionSettings getConnectionSettings() {
  return ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'tum',
      password: '1234',
      db: 'clinic');
}

class User {
  final int id;
  final String user;
  final String email;
  final String fullname;
  final String idcard;
  final DateTime birthdate;
  final String phone;
  final Blob disease;
  final Blob allergy;

  // ... other user data fields

  User({
    required this.id,
    required this.user,
    required this.email,
    required this.fullname,
    required this.idcard,
    required this.birthdate,
    required this.phone,
    required this.disease,
    required this.allergy,

    // ... other user data fields
  });
}

class News {
  final String topic;
  final String detail;

  News({
    required this.topic,
    required this.detail,
  });
}
