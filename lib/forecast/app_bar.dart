import 'package:flutter/material.dart';

class ForecastAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: false,
      title: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Thursday, August 29',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          new Text(
            'Sacramento',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
