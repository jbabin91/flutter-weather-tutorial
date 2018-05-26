import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget {
  final String text;

  SpinnerText({
    this.text = '',
  });

  @override
  _SpinnerTextState createState() => new _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = '';
  String bottomText = '';
  AnimationController _spinTextAnimationCrontroller;
  Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();

    bottomText = widget.text;

    _spinTextAnimationCrontroller = new AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = '';
            _spinTextAnimationCrontroller.value = 0.0;
          });
        }
      });

    _spinAnimation = new CurvedAnimation(
      parent: _spinTextAnimationCrontroller,
      curve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    _spinTextAnimationCrontroller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      topText = widget.text;
      _spinTextAnimationCrontroller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ClipRect(
      clipper: new RectClipper(),
      child: new Stack(
        children: <Widget>[
          new FractionalTranslation(
            translation: new Offset(0.0, _spinAnimation.value - 1.0),
            child: new Text(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          new FractionalTranslation(
            translation: new Offset(0.0, _spinAnimation.value),
            child: new Text(
              bottomText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
