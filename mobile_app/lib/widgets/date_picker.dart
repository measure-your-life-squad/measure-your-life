import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoosenDate extends StatefulWidget {
  @override
  _ChoosenDateState createState() => _ChoosenDateState();
  
}

class _ChoosenDateState extends State<ChoosenDate> {
  DateTime _selectedDate;


  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        // print('no date picked');
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    //  print('adding new date');
  }



  @override
  Widget build(BuildContext context) {


    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        
          Text(
            _selectedDate == null
                ? 'No Date Chosen!'
                : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
          ),
          FlatButton(
            textColor: Colors.black,
            child: Text(
              'Choose Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: _presentDatePicker,
          ),
        ],
      ),
    );
  }
}
