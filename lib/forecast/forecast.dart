import 'package:flutter/material.dart';
import 'package:weather_forecast/forecast/background/background_with_rings.dart';

class Forecast extends StatelessWidget {
  Widget _temperatureText() {
    return new Align(
        alignment: Alignment.centerLeft,
        child: new Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 10.0),
          child: new Text(
            '68°',
            style: new TextStyle(color: Colors.white, fontSize: 80.0),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new BackgroundWithRings(),
        _temperatureText(),
      ],
    );
  }
}
