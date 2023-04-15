import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({Key? key, required this.blogId});

  final int blogId;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  Map<String, dynamic> _blogData = {};

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
      'SELECT * FROM blog WHERE id = @id',
      substitutionValues: {'id': widget.blogId},
    );
    if (results.isNotEmpty) {
      setState(() {
        _blogData = results.first.toColumnMap();
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _blogData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        _blogData['topic'],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _blogData['img'] != null && _blogData['img'].isNotEmpty
                      ? Image.network(
                          _blogData['img'],
                          width: 400,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    _blogData['content'],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
