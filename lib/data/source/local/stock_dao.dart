// 데이터베이스에 접근하는 기능을 모아둠
import 'package:hive/hive.dart';

import 'company_listing_entity.dart';


class StockDao {
  //키값은 상수로 정의해서 사용하면 실수를 줄일 수 있다.
  static const companyListing = 'companyListing';
  final box = Hive.box('stock.db');

  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(StockDao.companyListing, companyListingEntity);
  }

  // 클리어
  Future clearComapnyListings() async {
    await box.close();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final List<CompanyListingEntity> companyListing =
        box.get(StockDao.companyListing, defaultValue: []);
    return companyListing
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
