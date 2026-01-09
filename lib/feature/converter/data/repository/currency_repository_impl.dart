import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:lirati/feature/converter/data/datasource/currency_remote_datasource.dart';
import 'package:lirati/feature/converter/domain/repository/currency_repository.dart';
import 'package:lirati/feature/converter/domain/entities/currency_rate.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_checker.dart';

@Injectable(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final NetworkChecker networkChecker;

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.networkChecker,
  });

  @override
  Future<Either<Failure, CurrencyRate>> getCurrencyRate(
    String currencySlug,
  ) async {
    final isConnected = await networkChecker.isConnected;
    if (!isConnected) {
      return Left(OfflineFailure('error_offline'));
    }

    try {
      final remoteRate = await remoteDataSource.getRate(currencySlug);
      return Right(remoteRate);
    } on ServerException catch (e) {
      final msg = (e.message.isNotEmpty) ? e.message : 'error_server';
      return Left(ServerFailure(msg));
    } on OfflineException catch (e) {
      return Left(OfflineFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('error_unexpected'));
    }
  }
}
