import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dependecies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initGetIt',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.initGetIt();


@module
abstract class InjectionModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker.createInstance();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
