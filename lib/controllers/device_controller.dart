import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../models/device_model.dart';

class DeviceController extends GetxController {
  final String url = "http://vpn.it-ot.club:8088/devicelist";

  List<DeviceList> deviceList = [];

  Future<void> getDevices() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final devices = deviceListFromJson(response.body);
      deviceList.add(devices);
      print(deviceList.map((e) => e.device2.bleAddress).toList());
      update();
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<void> connectWithBluetooth(String address) async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(address);
      print('Connected to the device');

      connection.input!.listen((Uint8List data) {
        print('Data incoming: ${ascii.decode(data)}');
        connection.output.add(data); // Sending data

        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print(exception.toString());
    }
  }

  @override
  void onInit() {
    getDevices();

    super.onInit();
  }
}
