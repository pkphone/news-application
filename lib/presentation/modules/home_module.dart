import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
      ];
}
