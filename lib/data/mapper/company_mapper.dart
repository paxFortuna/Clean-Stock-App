import 'package:clean_stock_app/data/source/local/company_listing_entity.dart';
import 'package:clean_stock_app/data/source/remote/dto/company_info_dto.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';

import '../../domain/model/company_info.dart';

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

extension ToCompanyInfo on CompanyInfoDto {
  CompanyInfo toCompanyInfo() {
    return CompanyInfo(symbol: symbol ?? '',
      description: description ?? '',
      name: name ?? '',
      country: country ?? '',
      industry: industry ?? '',);
  }
}
