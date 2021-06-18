import 'package:flutter/material.dart';

class MainShakeTransitions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shake Transitions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShakeTransition(
                child: Text(
                  'Hello World',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              const SizedBox(height: 20),
              ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1500),
                child: RaisedButton(
                  onPressed: () => null,
                  child: Text('Press me'),
                ),
              ),
              const SizedBox(height: 20),
              ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1100),
                offset: 300,
                child: Image.asset(
                  'assets/logo_azul.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1100),
                offset: 1000,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  const ShakeTransition(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 900),
      this.offset = 140,
      this.axis = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: child,
      duration: duration,
      curve: Curves.elasticOut,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(
                  value * offset,
                  0.0,
                )
              : Offset(
                  0.0,
                  value * offset,
                ),
          child: child,
        );
      },
    );
  }
}
