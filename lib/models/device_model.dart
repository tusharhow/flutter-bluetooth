// To parse this JSON data, do
//
//     final deviceList = deviceListFromJson(jsonString);

import 'dart:convert';

DeviceList deviceListFromJson(String str) => DeviceList.fromJson(json.decode(str));

String deviceListToJson(DeviceList data) => json.encode(data.toJson());

class DeviceList {
    DeviceList({
      required  this.device1,
      required  this.device2,
      required  this.device3,
    });

    Device device1;
    Device device2;
    Device device3;

    factory DeviceList.fromJson(Map<String, dynamic> json) => DeviceList(
        device1: Device.fromJson(json["device1"]),
        device2: Device.fromJson(json["device2"]),
        device3: Device.fromJson(json["device3"]),
    );

    Map<String, dynamic> toJson() => {
        "device1": device1.toJson(),
        "device2": device2.toJson(),
        "device3": device3.toJson(),
    };
}

class Device {
    Device({
      required  this.name,
      required  this.servicesUuid,
      required  this.characteristics,
      required  this.id,
      required  this.bleAddress,
    });

    String? name;
    String ?servicesUuid;
    String ?characteristics;
    int ?id;
    String? bleAddress;

    factory Device.fromJson(Map<String, dynamic> json) => Device(
        name: json["name"],
        servicesUuid: json["services.uuid"],
        characteristics: json["characteristics"],
        id: json["id"],
        bleAddress: json["ble_address"] == null ? null : json["ble_address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "services.uuid": servicesUuid,
        "characteristics": characteristics,
        "id": id,
        "ble_address": bleAddress == null ? null : bleAddress,
    };
}
