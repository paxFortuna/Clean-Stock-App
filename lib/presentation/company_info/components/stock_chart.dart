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
    return SizedBox(
      width: double.infinity,
      height: 250,
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

  final spacing = 50;

  ChartPainter(this.infos);

  @override
  void paint(Canvas canvas, Size size) {
    // 세로 텍스트
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
      tp.paint(canvas, Offset(10, size.height - spacing - i * (size.height / 5.0)));
    }
    // 가로 텍스트
    final spacePerHour = size.width / infos.length;
    for(var i = 0; i < infos.length; i += 12) {
      final hour = infos[i].date.hour;

      final tp = TextPainter(
        text: TextSpan(
          text: '$hour',
          style: const TextStyle(fontSize: 12),
        ),
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(i * spacePerHour + spacing, size.height -5));
    }
    // graph 차트 그리기 위치 정보 계산
    var lastX = 0.0;
    final strokePath = Path();
    for(var i = 0; i < infos.length; i++){
      final info = infos[i];
      var nextIndex = i + 1;
      if (i + 1 > infos.length - 1) nextIndex = infos.length - 1;
      final nextInfo = infos[nextIndex];
      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio = (nextInfo.close - lowerValue) / (upperValue - leftRatio);

      final x1 = spacing + i * spacePerHour;
      final y1 = size.height - spacing - (leftRatio * size.height).toDouble();
      final x2 = spacing + (i + 1) * spacePerHour;
      final y2 = size.height - spacing - (rightRatio * size.height).toDouble();

      if (i == 0) {
        strokePath.moveTo(x1, y2);
      }
      lastX = (x1 + x2) / 2.0;
      strokePath.quadraticBezierTo(x1, y1, lastX, (y1 + y2) / 2.0);
    }

    // graph 차트 그리기
    final strokePaint = Paint();


  }

  @override
  // bool shouldRepaint(covariant CustomPainter oldDelegate) {
  bool shouldRepaint(ChartPainter oldDelegate) {
    return oldDelegate.infos != infos;
  }
}
