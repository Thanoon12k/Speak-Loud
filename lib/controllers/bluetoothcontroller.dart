import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[].obs;

  FlutterBlue flutterBlue = FlutterBlue.instance;

  void scanDevices() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!devicesList.contains(r.device)) {
          devicesList.add(r.device);
        }
      }
    });
    flutterBlue.stopScan();
  }
}
