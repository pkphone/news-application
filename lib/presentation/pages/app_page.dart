import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/utils/string_util.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringUtil.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
      ),
    ).modular();
  }
}
