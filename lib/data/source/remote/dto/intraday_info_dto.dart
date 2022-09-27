import 'package:freezed_annotation/freezed_annotation.dart';

part 'intraday_info_dto.freezed.dart';

part 'intraday_info_dto.g.dart';

// 원 소스 데이트 그대로 받아야 함.
@freezed
class IntradayInfoDto with _$IntradayInfoDto {
  const factory IntradayInfoDto({
    required String timestamp,
    required double close,
  }) = _IntradayInfoDto;

  factory IntradayInfoDto.fromJson(Map<String, Object?> json) => _$IntradayInfoDtoFromJson(json);
}