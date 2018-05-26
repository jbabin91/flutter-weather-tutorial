import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/forecast/background/background_with_rings.dart';
import 'package:weather_forecast/forecast/radial_list.dart';

class Forecast extends StatelessWidget {
  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;

  Forecast({
    @required this.radialList,
    @required this.slidingListController,
  });

  Widget _temperatureText() {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Padding(
        padding: const EdgeInsets.only(top: 150.0, left: 10.0),
        child: new Text(
          '68°',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 80.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new BackgroundWithRings(),
        _temperatureText(),
        new SlidingRadialList(
          radialList: radialList,
          controller: slidingListController,
        )
      ],
    );
  }
}
