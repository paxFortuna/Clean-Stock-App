import 'package:clean_stock_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:clean_stock_app/domain/model/intraday_info.dart';
import 'package:intl/intl.dart';

extension ToIntradayInfo on IntradayInfoDto {
  IntradayInfo toIntradayInfo() {
    // 2022-09-26  5:50:00
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return IntradayInfo(
      date: formatter.parse(timestamp),
      close: close,
    );
  }
}
