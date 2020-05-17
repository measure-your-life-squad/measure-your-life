import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 10,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'MeasureYourLife',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        Text(
                          'Statistics',
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Text('Statistics'),
            )
          ],
        ),
      ),
    );
  }
}
