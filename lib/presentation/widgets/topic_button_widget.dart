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
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        child: Text(name),
      ),
    );
  }
}
