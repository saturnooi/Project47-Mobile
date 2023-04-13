import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<Map<String, dynamic>> _data = [];
  int _selectedScore = 0; // initially select all scores

  Future<void> _fetchData() async {
    final conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
      // useSSL: true,
    );
    await conn.open();

    final results = await conn.query('SELECT * FROM review');
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedScore = 0; // select all scores
                  });
                },
                child: const Text('All'),
              ),
              const SizedBox(width: 10),
              for (int score = 1; score <= 5; score++)
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedScore = score;
                    });
                  },
                  child: Text(score.toString()),
                  style: OutlinedButton.styleFrom(
                    primary: score == _selectedScore ? Colors.green : null,
                    side: BorderSide(
                      color:
                          score == _selectedScore ? Colors.green : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                if (_selectedScore != 0 && item['score'] != _selectedScore) {
                  // skip this item if it doesn't match selected score
                  return SizedBox.shrink();
                }
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < item['score']
                                ? Icons.star
                                : Icons.star_border,
                            color: Color.fromARGB(255, 222, 201, 10),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'ความคิดเห็น :',
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            item['comment_review'],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
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
