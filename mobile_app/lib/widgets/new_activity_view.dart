import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measure_your_life_app/widgets/activity_text_field.dart';
import 'package:measure_your_life_app/widgets/add_button.dart';
import 'package:measure_your_life_app/widgets/cancel_button.dart';
import 'package:measure_your_life_app/widgets/category_card.dart';

class NewActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                height: 4,
                width: 60,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Text(
              'Activity',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            buildCategories(),
            buildActivityName(),
            buildHours(context),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildHours(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Start time',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse('2020-01-01 12:00:00'),
                      minuteInterval: 15,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime value) {
                        print(value);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'End time',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse('2020-01-01 12:00:00'),
                      minuteInterval: 15,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime value) {
                        print(value);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategories() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Select category',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CategoryCard(
                'work',
                Icons.business,
                true,
              ),
              CategoryCard(
                'duties',
                Icons.content_paste,
                false,
              ),
              CategoryCard(
                'free time',
                Icons.event_available,
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildActivityName() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Type activity name',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: ActivityTextField(),
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: AddButton(
              'Add activity',
              Colors.white,
              Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: CancelButton(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }
}
