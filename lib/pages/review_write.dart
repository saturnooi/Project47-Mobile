import 'package:dental_clinic/pages/history.dart';
import 'package:flutter/material.dart';
import 'package:mysql_utils/mysql1/src/constants.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWrite extends StatefulWidget {
  const ReviewWrite({
    Key? key,
    required this.userId,
    required this.detail,
  }) : super(key: key);

  final int userId;
  final String detail;

  @override
  State<ReviewWrite> createState() => _ReviewWriteState();
}

class _ReviewWriteState extends State<ReviewWrite> {
  late PostgreSQLConnection _connection;
  int _rating = 0;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  Future<void> _connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
    );

    await _connection.open();
  }

  Future<void> _insertReview() async {
    final comment = _commentController.text;
    await _connection.query(
      'INSERT INTO review (reviewer_id,score,comment_review) values (@reviewer_id,@score,@comment_review)',
      substitutionValues: {
        'reviewer_id': widget.userId,
        'score': _rating,
        'comment_review': comment
      },
    );
  }

  Future<void> _updateHistory() async {
    await _connection.query(
        'UPDATE history_appointment SET confirm_review = @confirm_review WHERE patient_id = @patient_id AND detail = @detail',
        substitutionValues: {
          'confirm_review': 1,
          'patient_id': widget.userId,
          'detail': widget.detail,
        });
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
          Row(
            children: [
              Text('Score :'),
              RatingBar.builder(
                initialRating: _rating.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating.toInt();
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text('Comment :'),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _commentController,
                    onChanged: ((value) {}),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'แสดงความคิดเห็น',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint("Elevated Button");
              _insertReview();
              _updateHistory();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(
                    userId: widget.userId,
                  ),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
