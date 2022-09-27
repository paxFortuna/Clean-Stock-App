import 'dart:async';

import 'package:clean_stock_app/presentation/company_listings/company_listings_action.dart';
import 'package:clean_stock_app/presentation/company_listings/company_listings_state.dart';
import 'package:flutter/foundation.dart';

import '../../domain/repository/stock_repository.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyListingsState(); // 상태 변수 final은 안됨
  CompanyListingsState get state => _state;

  // debounce는 사용후 지워져야 하기에 널러벌 해야 함
  Timer? _debounce;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onAction(CompanyListingsAction action) {
    action.when(refresh: () => _getCompanyListings(fetchFromRemote: true),
    onSearchQueryChange: (query) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), (){
          _getCompanyListings(query: query);
        });
      }
    );
  }

  // ui에서 veiwModel이 호출되면 아래 메서드를 호출하여 데이터 읽어옴.
  Future _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    //로딩이 먼저 시작되어야 함. state불변객체는 copyWith로 교체
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        _state = state.copyWith(
          companies: listings,
        );
      },
      error: (e) {
        //todo: 에러처리
        print('리모트 에러: $e');
      },
    );

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }
}
