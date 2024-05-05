import 'package:flutter/material.dart';
import 'csv_data_service.dart';

void main() => runApp(const TripApp());

class TripApp extends StatelessWidget {
  const TripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _CsvDataScreen(),
    );
  }
}

class _CsvDataScreen extends StatefulWidget {
  @override
  _CsvDataScreenState createState() => _CsvDataScreenState();
}

class _CsvDataScreenState extends State<_CsvDataScreen> {
  List<List<dynamic>>? csvData;

  @override
  void initState() {
    super.initState();
    CsvDataService().loadCsvData().then((data) {
      setState(() {
        csvData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSV Data Table"),
      ),
      body: csvData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: _buildColumns(csvData!),
            rows: _buildRows(csvData!),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns(List<List<dynamic>> csvData) {
    return csvData.first.map((name) => DataColumn(label: Text(name.toString()))).toList();
  }

  List<DataRow> _buildRows(List<List<dynamic>> csvData) {
    return csvData.sublist(1).map((row) {
      return DataRow(cells: row.map((cell) => DataCell(Text(cell.toString()))).toList());
    }).toList();
  }
}