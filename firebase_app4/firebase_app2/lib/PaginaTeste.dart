import 'Calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1930),
                        lastDate: DateTime(2200),
                    ).then( (date) {
                      setState(() {
                        startTime = date;
                      });
                    });
                    // DatePicker.showDateTimePicker(context,
                    //     showTitleActions: true,
                    //     minTime: DateTime(2021, 1, 1),
                    //     maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                    //       print('change $date');
                    //     }, onConfirm: (date) {
                    //       setState(() {
                    //         this.startTime = date;
                    //       });
                    //     }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Event Start Time',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text('$startTime'),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2019, 3, 5),
                        maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            this.endTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Event End Time',
                    style: TextStyle(color: Colors.blue),
                  )),
              Text('$endTime'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _eventName,
              decoration: InputDecoration(hintText: 'Enter Event name'),
            ),
          ),
          RaisedButton(
              child: Text(
                'Insert Event',
              ),
              color: Colors.grey,
              onPressed: () {
                //log('add event pressed');
                calendarClient.insert(
                  _eventName.text,
                  startTime,
                  endTime,
                );
              }),
        ],
      ),
    );
  }
}