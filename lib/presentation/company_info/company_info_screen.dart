import 'package:clean_stock_app/presentation/company_info/company_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/company_info.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<CompanyInfoViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (state.errorMessage != null) Center(child: Text(state.errorMessage!)),
            if (state.isLoading) const Center(child: CircularProgressIndicator()),
            if (state.isLoading == false && state.errorMessage == null) _buildBody(state.companyInfo!),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(CompanyInfo companyInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(companyInfo.name),
          Text(companyInfo.symbol),
          Text(companyInfo.industry),
          Text(companyInfo.country),
          Text(companyInfo.description),
        ],
      ),
    );
  }
}
