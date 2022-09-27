import 'package:clean_stock_app/domain/model/company_info.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';

import '../../util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );

  Future<Result<CompanyInfo>> getCompanyInfo(String symbol);

}
