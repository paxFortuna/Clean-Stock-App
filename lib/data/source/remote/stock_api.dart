import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co';
  static const apiKey = 'F1R68TCH0OSLYQ6T';

  // client가 null이면 : client...을 불러 기본 Client불러온다. test 코드작성용
  final http.Client client;
  StockApi({http.Client? client}) : client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await client.get(
      Uri.parse('https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=$apiKey')
    );
  }
}