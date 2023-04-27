import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

import 'controllers/bluetoothcontroller.dart';

class BluetoothScreen extends StatelessWidget {
  final BluetoothController con = Get.put(BluetoothController());

  BluetoothScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: con.devicesList.length,
          itemBuilder: (BuildContext context, int index) {
            BluetoothDevice device = con.devicesList[index];
            return ListTile(
              title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
              subtitle: Text(device.id.toString()),
              onTap: () {
                // Do something when tapped
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          con.devicesList.clear();
          con.scanDevices();
        },
      ),
    );
  }
}
