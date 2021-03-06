import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:measure_your_life_app/models/activity.dart';
import 'package:measure_your_life_app/models/category.dart';
import 'package:measure_your_life_app/models/user.dart';
import 'package:measure_your_life_app/providers/activities_provider.dart';
import 'package:measure_your_life_app/providers/categories_provider.dart';
import 'package:measure_your_life_app/utils/time_converter.dart';
import 'package:measure_your_life_app/utils/validators.dart';
import 'package:measure_your_life_app/widgets/app_alert.dart';
import 'package:provider/provider.dart';

class NewActivityView extends StatefulWidget {
  final User user;
  final DateTime startTime;
  final DateTime endTime;

  NewActivityView({Key key, this.user, this.startTime, this.endTime})
      : super(key: key);

  @override
  _NewActivityViewState createState() => _NewActivityViewState();
}

class _NewActivityViewState extends State<NewActivityView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'name': '',
    'category_id': '',
    'activitystart': '',
    'activityend': '',
  };

  Category dropdownValue;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CategoriesProvider>(context, listen: false)
            .getCategories(widget.user.token));
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

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
            Expanded(child: _buildActivityInfo()),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      categoriesProvider.isFetching
                          ? Container()
                          : _buildCategoriesDropdown(categoriesProvider),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildActivityNameTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildActivityStartTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildActivityEndTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: buildButtons(context)),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fill in required data and keep track of your life balance',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesDropdown(var categoriesProvider) {
    List<Category> categories =
        categoriesProvider.getCategories(widget.user.token);

    return categoriesProvider.isFetching
        ? Container()
        : DropdownButtonFormField<Category>(
            value: dropdownValue,
            decoration: InputDecoration(border: OutlineInputBorder()),
            hint: Text('Activity category'),
            icon: Icon(
              Icons.category,
            ),
            onChanged: (Category newValue) {
              setState(
                () {
                  _formData['category_id'] = newValue.categoryId;
                  dropdownValue = newValue;
                },
              );
            },
            validator: (Category value) {
              return Validators.validateNullableField(
                  value, 'Activity category');
            },
            items: categories.map<DropdownMenuItem<Category>>(
              (Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          getIconGuessFavorMaterial(name: value.iconName),
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(value.name),
                      ],
                    ),
                  ),
                );
              },
            ).toList());
  }

  Widget _buildActivityNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Activity name',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.local_activity),
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        return Validators.validateField(value, 'Activity name');
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildActivityStartTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Activity start',
        hintText: '08:00',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.av_timer),
      ),
      initialValue: widget.startTime == null
          ? ''
          : DateFormat('HH:mm').format(widget.startTime),
      keyboardType: TextInputType.number,
      inputFormatters: [
        MaskTextInputFormatter(
            mask: '#@:&@', filter: Validators.getHourValidator())
      ],
      validator: (String value) {
        return Validators.validateField(value, 'Activity start');
      },
      onSaved: (String value) {
        DateTime dateTime = TimeConverter.getDateTime(value);
        _formData['activitystart'] = dateTime.toString();
      },
    );
  }

  Widget _buildActivityEndTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Activity end',
        hintText: '12:00',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.av_timer),
      ),
      initialValue: widget.endTime == null
          ? ''
          : DateFormat('HH:mm').format(widget.endTime),
      keyboardType: TextInputType.number,
      inputFormatters: [
        MaskTextInputFormatter(
            mask: '#@:&@', filter: Validators.getHourValidator())
      ],
      validator: (String value) {
        return Validators.validateField(value, 'Activity end');
      },
      onSaved: (String value) {
        DateTime dateTime = TimeConverter.getDateTime(value);
        _formData['activityend'] = dateTime.toString();
      },
    );
  }

  void addActivity(Function addActivity) async {
    if (!_formKey.currentState.validate() || dropdownValue == null) {
      return;
    }
    _formKey.currentState.save();

    var start = DateTime.parse(_formData['activitystart']);
    var end = DateTime.parse(_formData['activityend']);

    Activity activity = Activity(
      category: _formData['category_id'],
      name: _formData['name'],
      start: start,
      end: end,
      duration: end.difference(start).inMinutes,
    );

    ActivitiesApiResponse response;
    if (widget.startTime == null) {
      response = await addActivity(widget.user.token, activity);
    } else {
      response =
          await addActivity(widget.user.token, activity, date: DateTime.now());
    }

    if (response == ActivitiesApiResponse.Ok) {
      Navigator.pop(context);
    } else if (response == ActivitiesApiResponse.TimesOverlapping) {
      AppAlert.showAlert(
          context, 'Activity time overlapping with other activities');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not add activity, try again later'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    }
  }

  Widget buildButtons(BuildContext context) {
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.0,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Add activity',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => addActivity(activitiesProvider.addActivity),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.0,
                    ),
                    child: FittedBox(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
