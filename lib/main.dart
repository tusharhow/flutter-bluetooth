import 'package:bluetooth_devices/controllers/device_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bluetooth Devices'),
            const SizedBox(height: 20),
            GetBuilder<DeviceController>(
              init: DeviceController(),
              builder: (cont) => cont.deviceList.isEmpty
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: cont.deviceList.length,
                          itemBuilder: (_, index) {
                            final devices = cont.deviceList[index];
                            return ListTile(
                              title: Text(devices.device2.name.toString()),
                              subtitle: ElevatedButton(
                                onPressed: () => cont.connectWithBluetooth(
                                    devices.device2.bleAddress.toString()),
                                child: const Text('Connect'),
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
