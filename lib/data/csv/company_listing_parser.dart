import 'package:clean_stock_app/data/csv/csv_parser.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';
import 'package:csv/csv.dart';

// 인터페이스 구현 기능
class CompanyListingsParser implements CsvParser<CompanyListing> {
  @override
  Future<List<CompanyListing>> parse(String csvString) async {
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);
    csvValues.removeAt(0); // 컬럼명 row 제거

    return csvValues.map((e) {
      final symbol = e[0] ?? '';  // null인 값 처리
      final name = e[1] ?? '';
      final exchange = e[2] ?? '';
      return CompanyListing(
        symbol: symbol,
        name: name,
        exchange: exchange,
      );
    }).where((e) =>
    !e.symbol.isNotEmpty || !e.name.isNotEmpty || !e.exchange.isNotEmpty)
        .toList();
  }
}
