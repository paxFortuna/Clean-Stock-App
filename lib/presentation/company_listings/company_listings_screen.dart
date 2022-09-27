import 'package:clean_stock_app/domain/repository/stock_repository.dart';
import 'package:clean_stock_app/presentation/company_info/company_info_screen.dart';
import 'package:clean_stock_app/presentation/company_info/company_info_state.dart';
import 'package:clean_stock_app/presentation/company_info/company_info_view_model.dart';
import 'package:clean_stock_app/presentation/company_listings/company_listings_action.dart';
import 'package:clean_stock_app/presentation/company_listings/company_listings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CompanyListingsScreen extends StatelessWidget {
  const CompanyListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyListingsViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (query) {
                  viewModel.onAction(
                      CompanyListingsAction.onSearchQueryChange(query));
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  labelText: '검색...',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  viewModel.onAction(const CompanyListingsAction.refresh());
                },
                child: ListView.builder(
                  itemCount: state.companies.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(state.companies[index].name),
                          // 화면전환할 때 main의 proviers에 주입할 수 없기에 뷰모델을 직접 주입한다.
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                final repository =
                                    GetIt.instance<StockRepository>();
                                    // context.read<StockRepository>();
                                final symbol = state.companies[index].symbol;
                                return ChangeNotifierProvider(
                                  create: (_) =>
                                      CompanyInfoViewModel(repository, symbol),
                                  child: const CompanyInfoScreen(),
                                );
                              }),
                            );
                          },
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
