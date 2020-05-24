import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:icons_helper/icons_helper.dart';
import 'package:measure_your_life_app/models/category.dart';
import 'package:measure_your_life_app/models/gauge_segment.dart';
import 'package:measure_your_life_app/models/statistics.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/providers/statistics_provider.dart';
import 'package:measure_your_life_app/theme/constants.dart';
import 'package:measure_your_life_app/utils/category_theme.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  final User user;

  StatisticsPage({Key key, this.user}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool oldDate = true;
  var _startTimeController = TextEditingController();
  var startTimeDate;
  var _endTimeController = TextEditingController(
      text: DateFormat("dd MMMM yyyy").format(DateTime.now()));
  var endTimeDate;

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
      body: statisticsProvider.isFetching ||
              categoriesProvider.isFetching ||
              statisticsProvider.isFetchingOldestDate
          ? Center(child: CircularProgressIndicator())
          : _buildStatistics(
              statisticsProvider.statistics,
              categoriesProvider.getCategories(
                widget.user.token,
              ),
              statisticsProvider.oldestDate,
              statisticsProvider.getStatistics,
            ),
    );
  }

  Widget _buildStatistics(Statistics statistics, List<Category> categories,
      OldestDate oldestDate, Function getStats) {
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
                  bottom: 10,
                  left: 10,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Constants.appTitle,
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
                _buildActivityStartTextField(oldestDate, getStats, oldDate),
                _buildActivityEndTextField(getStats),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
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
                  height: MediaQuery.of(context).size.height * 0.33,
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
              .getOldestDate(widget.user.token),
          Provider.of<StatisticsProvider>(context, listen: false).getStatistics(
            widget.user.token,
          ),
          Provider.of<CategoriesProvider>(context, listen: false)
              .getCategories(widget.user.token),
        });
  }

  String _getOldestDate(OldestDate oldestDate) {
    return oldestDate == null
        ? ''
        : DateFormat("dd MMMM yyyy")
            .format(DateTime.parse(oldestDate.oldestDate));
  }

  showPickerDateRange(BuildContext context, Function getStats) {
    Picker ps = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          value: DateTime.now(),
          minuteInterval: 15,
          type: PickerDateTimeType.kDMY,
        ),
        onConfirm: (Picker picker, List value) {
          startTimeDate = (picker.adapter as DateTimePickerAdapter).value;
          _startTimeController.text = DateFormat("dd MMMM yyyy")
              .format((picker.adapter as DateTimePickerAdapter).value);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          value: DateTime.now(),
          type: PickerDateTimeType.kDMY,
        ),
        onConfirm: (Picker picker, List value) {
          endTimeDate = (picker.adapter as DateTimePickerAdapter).value;
          _endTimeController.text = DateFormat("dd MMMM yyyy")
              .format((picker.adapter as DateTimePickerAdapter).value);
        });

    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText)),
      FlatButton(
          onPressed: () {
            oldDate = false;
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);
            _getStats(getStats);
          },
          child: Text(PickerLocalizations.of(context).confirmText))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date Range"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Begin:"),
                  ps.makePicker(),
                  Text("End:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  Widget _buildActivityStartTextField(
      OldestDate oldestDate, Function getStats, bool oldDate) {
    _startTimeController.text =
        oldDate ? _getOldestDate(oldestDate) : _startTimeController.text;
    return TextFormField(
      controller: _startTimeController,
      readOnly: true,
      enabled: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Statistics Date Range',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.av_timer),
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Activity start time is empty';
        }

        return null;
      },
      onTap: () {
        showPickerDateRange(context, getStats);
      },
    );
  }

  Widget _buildActivityEndTextField(Function getStats) {
    return TextFormField(
      controller: _endTimeController,
      readOnly: true,
      enabled: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.av_timer),
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Activity end time is empty';
        }

        return null;
      },
      onTap: () {
        showPickerDateRange(context, getStats);
      },
    );
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.18,
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

    var color = CategoryTheme.getColor(category.name);
    var avg = getAverageTimeForCategory(category, statistics);

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
            (avg / 60).toString() + ' hrs',
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

  int getAverageTimeForCategory(Category category, Statistics statistics) {
    if (category.name == 'work') {
      return statistics.workAvg;
    } else if (category.name == 'duties') {
      return statistics.dutiesAvg;
    } else if (category.name == 'leisure') {
      return statistics.leisureAvg;
    }

    return 0;
  }

  void _getStats(Function getStats) async {
    var formattedStartDate = DateTime(
        startTimeDate.year, startTimeDate.month, startTimeDate.day, 2, 0);
    var formattedEndDate =
        DateTime(endTimeDate.year, endTimeDate.month, endTimeDate.day, 21, 59);
    await getStats(
      widget.user.token,
      startRange: formattedStartDate.toString(),
      endRange: formattedEndDate.toString(),
    );
  }
}
