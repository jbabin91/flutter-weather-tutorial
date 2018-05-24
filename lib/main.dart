import 'package:flutter/material.dart';
import 'package:weather_forecast/forecast/app_bar.dart';
import 'package:weather_forecast/forecast/background/background_with_rings.dart';
import 'package:weather_forecast/forecast/generic_widgets/sliding_drawer.dart';
import 'package:weather_forecast/forecast/week_drawer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  OpenableController openableController;
  String selectedDay = 'Monday, August 26';

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
      vsync: this,
      openDuration: const Duration(milliseconds: 250),
    )..addListener((() => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new BackgroundWithRings(),
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: new ForecastAppBar(
            onDrawerArrowTap: openableController.open,
            selectedDay: selectedDay,
          ),
        ),
        new SlidingDrawer(
          openableController: openableController,
          drawer: new WeekDrawer(
            onDaySelected: (String title) {
              setState(() {
                selectedDay = title.replaceAll('\n', ', ');
              });

              openableController.close();
            },
          ),
        ),
      ],
    ));
  }
}
