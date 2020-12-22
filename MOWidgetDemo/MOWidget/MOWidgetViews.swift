//
//  MOWidgetViews.swift
//  MOWidgetExtension
//
//  Created by 莫晓卉 on 2020/12/16.
//

import SwiftUI

struct MOCricleView: View {
  var progress: [Double]
  static let startDegress: Double = 30
  static let halfDegress: Double = 12.0
  let blueDegress: [Angle] = [.degrees(startDegress + 0 + halfDegress), .degrees(startDegress + 120 - halfDegress)]
  let greenDegress: [Angle] = [.degrees(startDegress + 120 + halfDegress), .degrees(startDegress + 240 - halfDegress)]
  let redDegress: [Angle] = [.degrees(startDegress + 240 + halfDegress), .degrees(startDegress + 360 - halfDegress)]
  
  var exerciseDegress: [Angle] = [.degrees(startDegress + 0 + halfDegress), .degrees(startDegress + 60 - halfDegress)]
  var activeDegress: [Angle] = [.degrees(startDegress + 240 + halfDegress), .degrees(startDegress + 300 - halfDegress)]
  var stepDegress: [Angle] = [.degrees(startDegress + 120 + halfDegress), .degrees(startDegress + 180 - halfDegress)]

  init(progress: [Double]) {
    self.progress = progress
    exerciseDegress = [.degrees(MOCricleView.startDegress + 0 + MOCricleView.halfDegress), .degrees(MOCricleView.startDegress + (progress[0] * 120) - MOCricleView.halfDegress)]
    activeDegress = [.degrees(MOCricleView.startDegress + 120 + MOCricleView.halfDegress), .degrees(MOCricleView.startDegress + 120 + (progress[1] * 120) - MOCricleView.halfDegress)]
    stepDegress = [.degrees(MOCricleView.startDegress + 240 + MOCricleView.halfDegress), .degrees(MOCricleView.startDegress + 240 + (progress[2] * 120) - MOCricleView.halfDegress)]
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: blueDegress[0], endAngle: blueDegress[1], clockwise: false)
        }
        .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: greenDegress[0], endAngle: greenDegress[1], clockwise: false)
        }
        .stroke(Color.green.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: redDegress[0], endAngle: redDegress[1], clockwise: false)
        }
        .stroke(Color.red.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        
        // value
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: exerciseDegress[0], endAngle: exerciseDegress[1], clockwise: false)
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: activeDegress [0], endAngle: activeDegress[1], clockwise: false)
        }
        .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: stepDegress[0], endAngle: stepDegress[1], clockwise: false)
        }
        .stroke(Color.red, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
      }
    }
  }
}

struct MOSmallView: View {
  
  var body: some View {
    VStack {
      HStack {
        MOCricleView(progress: [0.5, 0.3, 0.2])
          .frame(width: 52, height: 52, alignment: .leading)
          .foregroundColor(.blue)
        Spacer()
      }
      
      HStack {
        Text("--/--小时")
          .foregroundColor(.green)
          .font(.system(Font.TextStyle.body))
          .padding([.trailing])
        Spacer()
      }
      
      HStack {
        Text("--/--分钟")
          .foregroundColor(.blue)
          .font(.system(Font.TextStyle.body))
        Spacer()
      }
      
      HStack {
        Text("--/--步")
          .foregroundColor(.red)
          .font(.system(Font.TextStyle.body))
        Spacer()
      }

    }
    .padding()
    .alignmentGuide(.leading, computeValue: { dimension in
      dimension[.leading]
    })
  }
}
