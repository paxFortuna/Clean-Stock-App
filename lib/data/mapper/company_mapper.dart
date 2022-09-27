import 'package:clean_stock_app/data/source/local/company_listing_entity.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';

extension ToComapnyListing on CompanyListingEntity {
  CompanyListing toCompanyListing() {
    return CompanyListing(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}
extension ToComapnyListingEntity on CompanyListing {
  CompanyListingEntity toCompanyListingEntity() {
    return CompanyListingEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}
