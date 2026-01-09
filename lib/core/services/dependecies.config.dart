// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../feature/converter/data/datasource/currency_remote_datasource.dart'
    as _i906;
import '../../feature/converter/data/datasource/currency_remote_datasource_imp.dart'
    as _i129;
import '../../feature/converter/data/repository/currency_repository_impl.dart'
    as _i914;
import '../../feature/converter/domain/repository/currency_repository.dart'
    as _i922;
import '../../feature/converter/domain/usecases/get_currency_rate_usecase.dart'
    as _i883;
import '../../feature/converter/presentation/blocs/converter/converter_bloc.dart'
    as _i230;
import '../../feature/converter/presentation/blocs/currency/currency_bloc.dart'
    as _i1054;
import '../cubit/theme_cubit.dart' as _i319;
import '../network/network_checker.dart' as _i387;
import 'dependecies.dart' as _i1048;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i230.ConverterBloc>(() => _i230.ConverterBloc());
    gh.lazySingleton<_i319.ThemeCubit>(() => _i319.ThemeCubit());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectionModule.connectionChecker,
    );
    gh.lazySingleton<_i519.Client>(() => injectionModule.httpClient);
    gh.factory<_i387.NetworkChecker>(
      () => _i387.NetworkCheckerImp(gh<_i973.InternetConnectionChecker>()),
    );
    gh.factory<_i906.CurrencyRemoteDataSource>(
      () => _i129.CurrencyRemoteDataSourceImpl(client: gh<_i519.Client>()),
    );
    gh.factory<_i922.CurrencyRepository>(
      () => _i914.CurrencyRepositoryImpl(
        remoteDataSource: gh<_i906.CurrencyRemoteDataSource>(),
        networkChecker: gh<_i387.NetworkChecker>(),
      ),
    );
    gh.factory<_i883.GetCurrencyRateUsecase>(
      () => _i883.GetCurrencyRateUsecase(gh<_i922.CurrencyRepository>()),
    );
    gh.lazySingleton<_i1054.CurrencyBloc>(
      () => _i1054.CurrencyBloc(gh<_i883.GetCurrencyRateUsecase>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i1048.InjectionModule {}
