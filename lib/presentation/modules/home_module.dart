import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/presentation/pages/home_page.dart';
import 'package:news_application/presentation/pages/saved_articles_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const HomePage(),
        ),
        ChildRoute(
          '/saved-articles',
          child: (_, __) => const SavedArticlesPage(),
        ),
      ];
}
