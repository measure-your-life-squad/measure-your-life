import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:icons_helper/icons_helper.dart';
import 'package:measure_your_life_app/models/category.dart';
import 'package:measure_your_life_app/models/gauge_segment.dart';
import 'package:measure_your_life_app/models/statistics.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/providers/statistics_provider.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  final User user;

  StatisticsPage({Key key, this.user}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    initiateProviders();
  }

  @override
  Widget build(BuildContext context) {
    final statisticsProvider = Provider.of<StatisticsProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
      ),
      body: statisticsProvider.isFetching || categoriesProvider.isFetching
          ? Center(child: CircularProgressIndicator())
          : _buildStatistics(
              statisticsProvider.statistics,
              categoriesProvider.getCategories(
                widget.user.token,
              ),
            ),
    );
  }

  Widget _buildStatistics(Statistics statistics, List<Category> categories) {
    return SingleChildScrollView(
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
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildLifeBalanceStatistics(statistics),
                _buildAverageDailyTimesStatistics(categories, statistics),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifeBalanceStatistics(Statistics statistics) {
    return statistics == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Life balance',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: charts.PieChart(
                    _getStatistics(statistics),
                    behaviors: [
                      charts.DatumLegend(
                          position: charts.BehaviorPosition.start)
                    ],
                    animate: true,
                    defaultRenderer: charts.ArcRendererConfig(
                      arcWidth: 30,
                      startAngle: 4 / 5 * pi,
                      arcLength: 7 / 5 * pi,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  List<charts.Series<GaugeSegment, String>> _getStatistics(
      Statistics statistics) {
    final data = [
      GaugeSegment('work', statistics.workRatio),
      GaugeSegment('duties', statistics.dutiesRatio),
      GaugeSegment('leisure', statistics.leisureRatio),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        colorFn: (GaugeSegment segment, _) => getSegmentColor(segment.name),
        id: 'Balance',
        domainFn: (GaugeSegment segment, _) => segment.name,
        measureFn: (GaugeSegment segment, _) => segment.value,
        data: data,
      )
    ];
  }

  charts.Color getSegmentColor(String label) {
    if (label == 'work') {
      return charts.ColorUtil.fromDartColor(Colors.red[400].withOpacity(0.7));
    }

    if (label == 'duties') {
      return charts.ColorUtil.fromDartColor(
          Colors.orange[400].withOpacity(0.7));
    }

    return charts.ColorUtil.fromDartColor(Colors.green[400].withOpacity(0.7));
  }

  void initiateProviders() {
    Future.microtask(() => {
          Provider.of<StatisticsProvider>(context, listen: false)
              .getStatistics(widget.user.token),
          Provider.of<CategoriesProvider>(context, listen: false)
              .getCategories(widget.user.token),
        });
  }

  Widget _buildAverageDailyTimesStatistics(
      List<Category> categories, Statistics statistics) {
    return statistics == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Average daily times',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildAvgDailyStatistic('work', categories, statistics),
                    _buildAvgDailyStatistic('duties', categories, statistics),
                    _buildAvgDailyStatistic('leisure', categories, statistics),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildAvgDailyStatistic(
      String categoryName, List<Category> categories, Statistics statistics) {
    Category category =
        categories.firstWhere((category) => category.name == categoryName);

    var color;
    var avg;
    if (category.name == 'work') {
      color = Colors.red[400].withOpacity(0.7);
      avg = statistics.workAvg;
    } else if (category.name == 'duties') {
      color = Colors.orange[400].withOpacity(0.7);
      avg = statistics.dutiesAvg;
    } else if (category.name == 'leisure') {
      color = Colors.green[400].withOpacity(0.7);
      avg = statistics.leisureAvg;
    } else {
      color = Colors.black;
      avg = 0;
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color,
            width: 3.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                getIconGuessFavorMaterial(name: category.iconName),
                color: color,
                size: 20.0,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                categoryName,
                style: TextStyle(
                  color: color,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            avg.toString() + ' mins',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}