import 'package:flutter/material.dart';

class TopicButtonWidget extends StatelessWidget {
  const TopicButtonWidget({
    Key? key,
    required this.name,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        textStyle: const TextStyle(
          fontSize: 20.0,
        ),
      ),
      onPressed: onPressed,
      child: Text(name),
    );
  }
}
