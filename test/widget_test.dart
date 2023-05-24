// Widget 1
import 'package:flutter/material.dart';

class Widget1 extends StatefulWidget {
  @override
  _Widget1State createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Widget 1'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isButtonPressed = !_isButtonPressed;
            });
          },
          child: Text('Toggle Button'),
        ),
      ],
    );
  }
}

// Widget 2
class Widget2 extends StatelessWidget {
  final VoidCallback onPressed;

  Widget2({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Widget 2'),
        ElevatedButton(
          onPressed: onPressed,
          child: Text('Call Widget 1'),
        ),
      ],
    );
  }
}

// Usage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('State Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widget1(),
              Widget2(
                onPressed: () {
                  final widget1State =
                  context.findAncestorStateOfType<_Widget1State>();
                  if (widget1State != null) {
                    widget1State.setState(() {
                      // Cập nhật trạng thái của widget 1
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
