// 데이터베이스에 접근하는 기능을 모아둠
import 'package:hive/hive.dart';

import 'company_listing_entity.dart';


class StockDao {
  //키값은 상수로 정의해서 사용하면 실수를 줄일 수 있다.
  static const companyListing = 'companyListing';
  // final box = Hive.box('stock.db');

  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.addAll(companyListingEntities);
  }

  // 클리어
  Future clearComapnyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    final List<CompanyListingEntity> companyListing =
        box.values.toList();
    return companyListing
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
