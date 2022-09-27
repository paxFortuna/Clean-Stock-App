import 'package:clean_stock_app/domain/model/intraday_info.dart';
import 'package:flutter/material.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfo> infos;

  const StockChart({
    Key? key,
    this.infos = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.red,
    );
  }
}
