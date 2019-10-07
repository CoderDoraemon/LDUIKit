//
//  UIDevice+.swift
//  SwiftExtension
//
//  Created by LDD on 2019/10/7.
//

import UIKit
import DeviceKit

public extension UIDevice {

    static let model: String = {
        return Device.current.description
    }()

    static let isiPhoneXSeries: Bool = {
        struct Anchor {
            static var result: Bool?
        }
        if let result = Anchor.result {
            return result
        }

        let iPhoneXSeries: [Device] = Device.allXSeriesDevices + Device.allSimulatorXSeriesDevices
        let result: Bool = iPhoneXSeries.contains(Device.current)
        Anchor.result = result
        return result
    }()
}
