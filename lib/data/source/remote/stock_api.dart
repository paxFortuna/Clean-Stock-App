import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co';
  static const apiKey = 'F1R68TCH0OSLYQ6T';

  final http.Client client;

  StockApi(this.client);

  Future<http.Response> getListings(String apiKey) async {
    return await client.get(
      Uri.parse('baseUrl/query?function=LISTING_STATUS&apikey=$apiKey')
    );
  }


}