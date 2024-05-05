import 'package:flutter/services.dart';

class PlatformServices {
  static const platform = MethodChannel('com.hackupc2024/channel');

  static Future<void> sendDataToWidget(List<dynamic> rowData) async {
    try {
      final String result = await platform.invokeMethod('updateWidget', {'data': rowData});
      print('Data sent to widget: $result');
    } on PlatformException catch (e) {
      print("Failed to send data: '${e.message}'.");
    }
  }
}

void onRowSelected(List<dynamic> selectedRow) {
  PlatformServices.sendDataToWidget(selectedRow);
}
