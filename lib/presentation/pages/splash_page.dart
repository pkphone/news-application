import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({Key? key}) : super(key: key);

  @override
  State<SpalshPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.pushReplacementNamed(
        '/home/',
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }
}
