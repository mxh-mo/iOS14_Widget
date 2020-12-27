//
//  MOWidgetCommons.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import Foundation
import SwiftUI

public func kScale() -> CGFloat {
  return CGFloat(MOFitnessData.shared.scale)
}

public func rgbColor(_ color: Int64) -> Color {
  return Color(red: Double((color & 0x00ff0000) >> 16) / 255.0,
                 green: Double((color & 0x0000ff00) >> 8) / 255.0,
                 blue: Double((color & 0x000000ff)) / 255.0)
}
