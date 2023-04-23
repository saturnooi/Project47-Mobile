import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/pages/queue_page.dart';
import 'dart:math';

class Appointment extends StatefulWidget {
  const Appointment({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final _formKey = GlobalKey<FormState>();
  final _symtomController = TextEditingController();
  bool? isCheckbox = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now().replacing(minute: 0);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  List<TimeOfDay> getAvailableTimes() {
    final start = TimeOfDay(hour: 8, minute: 0);
    final end = TimeOfDay(hour: 17, minute: 0);
    final availableTimes = <TimeOfDay>[];
    var time = start;
    while (time == end) {
      availableTimes.add(time);
      time = time.replacing(
          minute: time.minute == 0 ? 30 : 0,
          hour: time.minute == 30 ? time.hour + 1 : time.hour);
    }
    return availableTimes;
  }

  late PostgreSQLConnection _connection;

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  Future<void> _connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'db-postgresql-sgp1-56608-do-user-12968204-0.b.db.ondigitalocean.com',
      25060,
      'defaultdb',
      username: 'doadmin',
      password: 'AVNS_bXQmx_V8B3bMS_Dhhh2',
      useSSL: true,
    );

    await _connection.open();
  }

  Future<void> _insertAppointment() async {
    final String symtom = _symtomController.text;

    int randomId = 0;
    bool isIdUnique = false;
    while (!isIdUnique) {
      randomId = Random().nextInt(99999); // generate random ID
      final result = await _connection.query(
          'SELECT COUNT(*) FROM patient WHERE id = @id',
          substitutionValues: {'id': randomId});
      final count = result[0][0] as int;
      isIdUnique = count == 0;
    }

    if (isIdUnique == true) {
      await _connection.query(
        'INSERT INTO queue (id,"patientId", symtom, time_start,time_end,status) VALUES (@id,@patient_id,@symtom, @date_start , @date_end , @status)',
        substitutionValues: {
          'id': randomId,
          'patient_id': widget.userId,
          'symtom': symtom,
          'date_start': DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute),
          'date_end': DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute + 30),
          'status': 'รอการยืนยันจากคลินิก',
        },
      );
    }
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _symtomController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "อาการของคนไข้",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Checkbox(
                    value: isCheckbox,
                    onChanged: (bool? newBool) {
                      setState(
                        () {
                          isCheckbox = newBool;
                        },
                      );
                    },
                  ),
                  Text('เลือกทันตแพทย์ที่ต้องการ')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined),
                          const SizedBox(width: 8.0),
                          Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          // const Icon(Icons.calendar_today_outlined),
                          const SizedBox(width: 8.0),
                          Text(
                            "${selectedTime.hour}:${selectedTime.minute}",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint("Elevated Button");
                  _insertAppointment();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QueuePage(
                        userId: widget.userId,
                      ),
                    ),
                  );
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
