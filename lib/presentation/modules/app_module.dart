import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_application/data/api_client.dart';
import 'package:news_application/data/api_service.dart';
import 'package:news_application/data/repositories/article_repo_impl.dart';
import 'package:news_application/data/repositories/local_data_source_impl.dart';
import 'package:news_application/data/repositories/remote_data_source_impl.dart';
import 'package:news_application/domain/usecases/article_usecase.dart';
import 'package:news_application/presentation/mobx/home_store.dart';
import 'package:news_application/presentation/modules/home_module.dart';
import 'package:news_application/presentation/pages/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind(
          (i) => APIClient(),
        ),
        Bind(
          (i) => APIService(
            i.get<APIClient>().dio,
          ),
        ),
        Bind(
          (i) => RemoteDataSourceImpl(),
        ),
        Bind(
          (i) => ArticleRepoImpl.instance,
        ),
        Bind(
          (i) => ArticleUsecase(
            i.get(),
          ),
        ),
        Bind(
          (i) => HomeStore(),
        ),
        Bind(
          (i) => LocalDataSourceImpl(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, __) => const SplashPage(),
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
        ),
      ];
}
