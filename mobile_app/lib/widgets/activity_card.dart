import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:intl/intl.dart';
import 'package:measure_your_life_app/models/activity.dart';
import 'package:measure_your_life_app/models/category.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final List<Category> categories;

  ActivityCard(this.activity, this.categories);

  @override
  Widget build(BuildContext context) {
    var color;

    if (categories == null) {
      return Container();
    }

    Category category = categories
        .firstWhere((element) => element.categoryId == activity.category);

    if (category.name == 'work') {
      color = Colors.red[400].withOpacity(0.7);
    } else if (category.name == 'duties') {
      color = Colors.orange[400].withOpacity(0.7);
    } else if (category.name == 'leisure') {
      color = Colors.green[400].withOpacity(0.7);
    } else {
      color = Colors.black;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 4.0,
      ),
      child: Card(
        elevation: 8.0,
        child: Row(
          children: <Widget>[
            Container(
              width: 4,
              color: color,
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        activity.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Column(
                          children: <Widget>[
                            displayActivityTime(
                              'from',
                              activity.start,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            displayActivityTime(
                              'to',
                              activity.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          getIconGuessFavorMaterial(name: category.iconName),
                          color: color,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: color,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      activity.duration.toString() + ' mins',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget displayActivityTime(String label, DateTime time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label),
        ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            color: Colors.grey.withOpacity(0.2),
            child: Center(
              child: Text(
                DateFormat.Hm().format(time),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
