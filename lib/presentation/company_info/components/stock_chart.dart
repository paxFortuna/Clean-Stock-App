import 'dart:math';

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
      child: CustomPaint(
        painter: ChartPainter(infos),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfo> infos;

  late int upperValue =
     infos.map((e) => e.close)
         .fold<double>(0.0, max).ceil();

  late int lowerValue =
     infos.map((e) => e.close)
         .reduce(min).toInt();

  ChartPainter(this.infos);

  @override
  void paint(Canvas canvas, Size size) {
    final priceStep = (upperValue - lowerValue) / 5.0;
    for (var i = 0; i < 5; i++) {
      // tp: 위치 지정값
      final tp = TextPainter(
        text: TextSpan(
          text: '${(lowerValue + priceStep * i).round()}',
          style: const TextStyle(fontSize: 12),
        ),
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(10, size.height - i * (size.height / 5.0)));
    }
  }

  @override
  // bool shouldRepaint(covariant CustomPainter oldDelegate) {
  bool shouldRepaint(ChartPainter oldDelegate) {
    return oldDelegate.infos != infos;
  }
}
