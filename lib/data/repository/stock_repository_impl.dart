import 'package:clean_stock_app/data/csv/company_listing_parser.dart';
import 'package:clean_stock_app/data/mapper/company_mapper.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';
import 'package:clean_stock_app/domain/repository/stock_repository.dart';
import 'package:clean_stock_app/util/result.dart';

import '../source/local/stock_dao.dart';
import '../source/remote/stock_api.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _parser = CompanyListingsParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(bool fetchFromRemote,
      String query) async {
    // 캐시 dao에서 찾는다
    final localListings = await _dao.searchCompanyListing(query);

    // 없다면 리모트에서 가져온다.
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    if (shouldJustLoadFromCache) {
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList()
      );
    }
    // 리모트
    // Future<http.Response> getListings({String apiKey = apiKey})
    try {
      final response = await _api.getListings();
      final remoteListings = await _parser.parse(response.body);

      // 캐싱 - entity로 변환해서 hive db에 저장
      await _dao.insertCompanyListings(
          remoteListings.map((e) => e.toCompanyListingEntity()).toList()
      );
      return Result.success(remoteListings);

    } catch(e) {
      return Result.error(Exception('데이터 로드 실패'));
    }

  }

}