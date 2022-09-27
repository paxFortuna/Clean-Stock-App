// 인터페이스
abstract class CsvParser<T> {
  Future<List<T>> parse(String csvString);
}