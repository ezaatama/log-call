import 'package:call_log/call_log.dart';
import 'package:contact_call_log/calendar_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  DateTime? _startDate;
  DateTime? _endDate;

  void _updateDateRange(DateTime dateTime) {
    if (_startDate == null || dateTime.isBefore(_startDate!)) {
      _startDate = dateTime;
    }
    if (_endDate == null || dateTime.isAfter(_endDate!)) {
      _endDate = dateTime;
    }
  }

  @override
  void initState() {
    super.initState();
    _callLogEntries = <CallLogEntry>[];
    _startDate = null;
    _endDate = null;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle mono = TextStyle(fontFamily: 'monospace');
    final List<Widget> children = <Widget>[];
    for (CallLogEntry entry in _callLogEntries) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      // Dapatkan tanggal, bulan, dan tahun dari objek DateTime
      int year = dateTime.year;
      int month = dateTime.month;
      int day = dateTime.day;

      // Format tanggal, bulan, dan tahun menjadi string
      String formattedDate = '$year-$month-$day';
      _updateDateRange(dateTime);

      children.add(
        Column(
          children: <Widget>[
            const Divider(),
            Text('NUMBER     : ${entry.number}', style: mono),
            Text('NAME       : ${entry.name}', style: mono),
            Text('TYPE       : ${entry.callType}', style: mono),
            Text(
                'TIMESTAMP   : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
                style: mono),
            Text('DATE       : $formattedDate', style: mono),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('call_log example')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Date Range: ${_startDate != null && _endDate != null ? '${_startDate!.toString()} - ${_endDate!.toString()}' : 'No data'}',
                  style: mono),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final Iterable<CallLogEntry> result = await CallLog.query();
                    setState(() {
                      _callLogEntries = result;
                    });
                  },
                  child: const Text('Get all'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: children),
            ),
          ],
        ),
      ),
    );
  }
}
