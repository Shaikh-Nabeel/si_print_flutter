import 'package:flutter/material.dart';

int convertDateToMilliseconds(String date) {
  try {
    final DateTime parsedDate = DateTime.parse(
      '${date.split('-')[2]}-${date.split('-')[1]}-${date.split('-')[0]}T00:00:01',
    );
    return parsedDate.millisecondsSinceEpoch;
  } catch (e) {
    throw FormatException('Invalid date format. Please use dd-MM-yyyy.');
  }
}


class DateInputPage extends StatefulWidget {
  @override
  _DateInputPageState createState() => _DateInputPageState();
}

class _DateInputPageState extends State<DateInputPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _calculateMilliseconds() {
    String date = _controller.text;
    try {
      int milliseconds = convertDateToMilliseconds(date);
      setState(() {
        _result = 'Milliseconds since epoch: $milliseconds';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Date (dd-MM-yyyy)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateMilliseconds,
              child: Text('Convert to Milliseconds'),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
