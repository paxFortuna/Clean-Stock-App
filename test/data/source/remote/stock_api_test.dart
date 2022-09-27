import 'package:clean_stock_app/data/csv/company_listing_parser.dart';
import 'package:clean_stock_app/data/source/remote/stock_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  test('네트워크 통신', () async {
    final response = await StockApi().getListings();

    final _parser = CompanyListingsParser();
    final remoteListings = await _parser.parse(response.body);
    expect(remoteListings[0].symbol, 'AGM-P-E');
    expect(remoteListings[0].name, '');
    expect(remoteListings[0].exchange, 'NYSE');

  });
}