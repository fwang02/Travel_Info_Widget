import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class CsvDataService {
  Future<List<List<dynamic>>> loadCsvData() async {
    final rawData = await rootBundle.loadString('assets/database.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    return listData;
  }
}
