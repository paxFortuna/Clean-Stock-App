import 'package:clean_stock_app/data/csv/company_listing_parser.dart';
import 'package:clean_stock_app/data/mapper/company_mapper.dart';
import 'package:clean_stock_app/domain/model/company_info.dart';
import 'package:clean_stock_app/domain/model/company_listing.dart';
import 'package:clean_stock_app/domain/model/intraday_info.dart';
import 'package:clean_stock_app/domain/repository/stock_repository.dart';
import 'package:clean_stock_app/util/result.dart';

import '../csv/intraday_info_parser.dart';
import '../source/local/stock_dao.dart';
import '../source/remote/stock_api.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _companyListingsParser = CompanyListingsParser();
  final _intradayInfoParser = IntradayInfoParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    // 캐시 dao에서 찾는다. 있다면 ...Entity에서 가져오고, 없다면 리모트에서
    final localListings = await _dao.searchCompanyListing(query);

    // 없다면 리모트에서 가져온다.
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시
    if (shouldJustLoadFromCache) {
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList());
    }
    // 리모트
    // Future<http.Response> getListings({String apiKey = apiKey}) 설정
    try {
      final response = await _api.getListings();
      final remoteListings = await _companyListingsParser.parse(response.body);

      // 캐시 비우기
      await _dao.clearComapnyListings();

      // 캐싱 추가 - entity로 변환해서 hive db에 저장
      await _dao.insertCompanyListings(
          remoteListings.map((e) => e.toCompanyListingEntity()).toList());

      return Result.success(remoteListings);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패'));
    }
  }

  @override
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(symbol: symbol);
      //dto와 CompanyInfo 변환은 Mapper에 추가해야 함
      return Result.success(dto.toCompanyInfo());
    } catch (e) {
      return Result.error(Exception('회사 정보 로드 실패!! : ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<IntradayInfo>>> getIntradayInfo(String symbol) async {
    try{
      final response = await _api.getIntradayInfo(symbol: symbol);
      final results = await _intradayInfoParser.parse(response.body);
      return Result.success(results);

    }catch(e){
       return Result.error(Exception('intraday 정보 로드 실패!!! : ${e.toString()}'));
    }
  }
}
