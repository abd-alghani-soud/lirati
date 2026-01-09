import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:lirati/feature/converter/data/datasource/currency_remote_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../models/currency_rate_model.dart';

@Injectable(as: CurrencyRemoteDataSource)
class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final http.Client client;

  CurrencyRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrencyRateModel> getRate(String currencySlug) async {
    final url = 'https://sp-today.com/currency/$currencySlug?_rsc=1a28h';
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        },
      );

      if (response.statusCode == 200) {
        return CurrencyRateModel.fromRawHtml(response.body, currencySlug);
      } else {
        throw ServerException('error_server');
      }
    } on SocketException {
      throw OfflineException('error_offline');
    } catch (e) {
      throw ServerException('error_unexpected');
    }
  }
}
