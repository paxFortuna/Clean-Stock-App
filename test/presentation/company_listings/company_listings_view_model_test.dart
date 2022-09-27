import 'package:clean_stock_app/data/repository/stock_repository_impl.dart';
import 'package:clean_stock_app/data/source/local/company_listing_entity.dart';
import 'package:clean_stock_app/data/source/local/stock_dao.dart';
import 'package:clean_stock_app/data/source/remote/stock_api.dart';
import 'package:clean_stock_app/presentation/company_listings/company_listings_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('company_listings-view_model 생성시 데이터를 잘 가져와야 한다', () async {
    Hive.init(null);
    // hive_generator build_runner 실행 이후 설정
    Hive.registerAdapter(CompanyListingEntityAdapter());
    final _api = StockApi();
    final _dao = StockDao();
    final viewModel = CompanyListingsViewModel(StockRepositoryImpl(_api, _dao));

    await Future.delayed(const Duration(seconds: 2));
    
    expect(viewModel.state.companies.isNotEmpty, true);
  });
}