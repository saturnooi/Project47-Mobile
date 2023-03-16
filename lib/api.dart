import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

Future operation() async {
  var conn = PostgreSQLConnection(
    'db-postgresql-sgp1-56608-do-',
    25060,
    'defaultdb',
    username: 'doadmin',
    password: 'AVNS_bXQmx_V8B3bMS_Dhhh2',
  );

  try {
    await conn.open();
    print("Connected");
  } catch (e) {
    print("error");
    print(e.toString());
  }

  Future<List<News>> getNews() async {
    final results = await conn.query('SELECT * FROM news');
    final news = results
        .map((row) => News(
              writer_id: results[0][0] as int,
              topic: results[0][1] as String,
              detail: results[0][2] as String,
              date_write: results[0][3] as DateTime,
            ))
        .toList();
    return news;
  }
}

class News {
  final int writer_id;
  final String topic;
  final String detail;
  final DateTime date_write;

  News(
      {required this.writer_id,
      required this.topic,
      required this.detail,
      required this.date_write});
}
