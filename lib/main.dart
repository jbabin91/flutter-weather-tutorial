import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/forecast/app_bar.dart';
import 'package:weather_forecast/forecast/background/background_with_rings.dart';
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

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
      vsync: this,
      openDuration: const Duration(milliseconds: 250),
    )
      ..addListener((() => setState(() {})))
      ..open();
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
          child: new ForecastAppBar(),
        ),
        new Stack(
          children: <Widget>[
            new GestureDetector(
              onTap:
                  openableController.isOpen() ? openableController.close : null,
            ),
            new Transform(
              transform: new Matrix4.translationValues(
                  125.0 * (1.0 - openableController.percentOpen), 0.0, 0.0),
              child: new Align(
                alignment: Alignment.centerRight,
                child: new WeekDrawer(),
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class OpenableController extends ChangeNotifier {
  OpenableState _state = OpenableState.closed;
  AnimationController _opening;

  OpenableController({
    @required TickerProvider vsync,
    @required Duration openDuration,
  }) : _opening =
            new AnimationController(duration: openDuration, vsync: vsync) {
    _opening
      ..addListener(notifyListeners)
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = OpenableState.opening;
            break;
          case AnimationStatus.completed:
            _state = OpenableState.open;
            break;
          case AnimationStatus.reverse:
            _state = OpenableState.closing;
            break;
          case AnimationStatus.dismissed:
            _state = OpenableState.closing;
            break;
        }
        notifyListeners();
      });
  }

  get state => _state;

  get percentOpen => _opening.value;

  bool isOpen() {
    return _state == OpenableState.open;
  }

  bool isOpening() {
    return _state == OpenableState.opening;
  }

  bool isClosed() {
    return _state == OpenableState.closed;
  }

  bool isClosing() {
    return _state == OpenableState.closing;
  }

  void open() {
    _opening.forward();
  }

  void close() {
    _opening.reverse();
  }

  void toggle() {
    if (isClosed()) {
      open();
    } else if (isOpen()) {
      close();
    }
  }
}

enum OpenableState {
  closed,
  opening,
  open,
  closing,
}
