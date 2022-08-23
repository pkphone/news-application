import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/models/type_registrars.dart';
import 'package:news_application/presentation/modules/app_module.dart';
import 'package:news_application/presentation/pages/app_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdapters();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
