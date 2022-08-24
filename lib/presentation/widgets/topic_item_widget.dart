import 'package:flutter/material.dart';
import 'package:news_application/presentation/utils/string_util.dart';
import 'package:news_application/presentation/widgets/topic_button_widget.dart';

class TopicItemWidget extends StatelessWidget {
  const TopicItemWidget({
    Key? key,
    required this.topic,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  final String topic;
  final int index;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TopicButtonWidget(
      color: topic == StringUtil.topics[index] ? Colors.blue : Colors.grey,
      name: StringUtil.topics[index],
      onPressed: onPressed,
    );
  }
}
