//
//  IntentHandler.swift
//  MOConfigurationIntent
//
//  Created by 莫晓卉 on 2021/1/13.
//

import Intents
//
//public class Device: INObject {
//    @available(iOS 13.0, macOS 11.0, watchOS 6.0, *)
//    @NSManaged public var name: String?
//}

struct MODevice {
  let id: String
  let name: String
  
  static let availableTicWatch = [
    MODevice(id: "01", name: "TicWatch"),
    MODevice(id: "02", name: "TicWatch Pro"),
    MODevice(id: "03", name: "TicWatch E3")
  ]
  static let availableTicPod = [
    MODevice(id: "01", name: "TicPod"),
    MODevice(id: "02", name: "TicPod Pro"),
    MODevice(id: "03", name: "TicPod Plus")
  ]
}


class IntenHandler: INExtension, ConfigurationIntentHandling {
//  func resolveDeviceType(for intent: ConfigurationIntent, with completion: @escaping (DeviceTypeResolutionResult) -> Void) {
//    completion(MODeviceTypeResolutionResult())
//  }
  
  func provideDeviceOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<Device>?, Error?) -> Void) {

    var availableDevices: [MODevice] = MODevice.availableTicWatch

    switch intent.deviceType {
    case .ticWatch: availableDevices = MODevice.availableTicWatch
    case .ticPod: availableDevices = MODevice.availableTicPod
    default: availableDevices = MODevice.availableTicWatch
    }

    let characters: [Device] = availableDevices.map { device in
      let gameCharacter = Device (
        identifier: device.id,
        display: device.name
      )
      return gameCharacter
    }
    let collection = INObjectCollection(items: characters)

    completion(collection, nil)
  }
  override func handler(for intent: INIntent) -> Any {
      return self
  }
}
