import 'dart:convert';

import 'package:clean_stock_app/data/source/remote/dto/company_info_dto.dart';
import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co';
  static const apiKey = 'F1R68TCH0OSLYQ6T';

  // client가 null이면 : client...을 불러 기본 Client불러온다. test 코드작성용
  final http.Client client;

  StockApi({http.Client? client}) : client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo(
      {required String symbol, String apiKey = apiKey}) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }

//  https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo

  Future<http.Response> getIntradayInfo({
    required String symbol,
    String apiKey = apiKey,
  }) async {
    return await client.get(Uri.parse(
        '$baseUrl/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=60min&apikey=$apiKey&datatype=csv'));

// TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo&datatype=csv
  }
}
