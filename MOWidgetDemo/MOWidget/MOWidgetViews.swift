//
//  MOWidgetViews.swift
//  MOWidgetExtension
//
//  Created by 莫晓卉 on 2020/12/16.
//

import SwiftUI

struct MOCricleView: View {
  static let startDegress: Double = 30
  static let halfDegress: Double = 12.0
  let length: Double = 96
  
  var progress: [Double]
  let blueDegress: [Angle]
  let greenDegress: [Angle]
  let redDegress: [Angle]
  
  var exerciseDegress: [Angle]
  var activeDegress: [Angle]
  var stepDegress: [Angle]

  init(progress: [Double]) {
    self.progress = progress
    
    blueDegress = MOCricleView.calculateDegress(0, 120)
    greenDegress = MOCricleView.calculateDegress(120, 240)
    redDegress = MOCricleView.calculateDegress(240, 360)
    
    exerciseDegress = MOCricleView.calculateDegress(0, (progress[0] * length))
    activeDegress = MOCricleView.calculateDegress(120, 120 + (progress[1] * length))
    stepDegress = MOCricleView.calculateDegress(240, 240 + (progress[2] * length))
    
    print("exerciseDegress: \(exerciseDegress[0].degrees) - \(exerciseDegress[1].degrees)")
    print("activeDegress: \(activeDegress[0].degrees) - \(activeDegress[1].degrees)")
    print("stepDegress: \(stepDegress[0].degrees) - \(stepDegress[1].degrees)")
  }
  
  static func calculateDegress(_ start: Double, _ end: Double) -> [Angle] {
    print("calculateDegress: \(start) - \(end)")
    return [.degrees(startDegress + start + halfDegress), .degrees(startDegress + end - halfDegress)]
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: blueDegress[0],
            endAngle: blueDegress[1],
            clockwise: false
          )
        }
        .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: greenDegress[0],
            endAngle: greenDegress[1],
            clockwise: false
          )
        }
        .stroke(Color.green.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: redDegress[0],
            endAngle: redDegress[1],
            clockwise: false
          )
        }
        .stroke(Color.red.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        
        // value
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: exerciseDegress[0],
            endAngle: exerciseDegress[1],
            clockwise: false
          )
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: activeDegress[0],
            endAngle: activeDegress[1],
            clockwise: false
          )
        }
        .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: stepDegress[0],
            endAngle: stepDegress[1],
            clockwise: false
          )
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
        MOCricleView(progress: [0.3, 0.2, 0.2])
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
