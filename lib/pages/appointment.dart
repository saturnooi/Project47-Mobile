import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/pages/queue_page.dart';

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
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
    );

    await _connection.open();
  }

  Future<void> _insertAppointment() async {
    final String symtom = _symtomController.text;

    await _connection.query(
      'INSERT INTO appointment (patient_id, symtom, date_appoint,time_appoint,status) VALUES (@patient_id,@symtom, @date_appoint, @time_appoint,@status)',
      substitutionValues: {
        'patient_id': widget.userId,
        'symtom': symtom,
        'date_appoint': selectedDate.toIso8601String(),
        'time_appoint': selectedTime.format(context),
        'status': 'รอการยืนยันจากคลินิก',
      },
    );
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _symtomController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "อาการของคนไข้",
                    border: InputBorder.none,
                  ),
                ),
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
              Row(
                children: [
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
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
                          const Icon(Icons.calendar_today_outlined),
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
