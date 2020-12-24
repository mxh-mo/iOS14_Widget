//
//  MOWidgetViews.swift
//  MOWidgetExtension
//
//  Created by 莫晓卉 on 2020/12/16.
//

import SwiftUI

struct MOCricleView: View {
  var progress: [Float]
  // background
  let blueDegress: [Angle]
  let greenDegress: [Angle]
  let redDegress: [Angle]
  // value
  var exerciseDegress: [Angle]
  var activeDegress: [Angle]
  var stepDegress: [Angle]
  
  let maximum: Float = 96

  // origin value: 0-120 120-240 240-360
  // margin value: 12-108 132-228 252-348 (间距: 24)
  // offset value: 42-138 162-258 282-378 (调整角度: 偏移30)
  init(progress: [Float]) {
    self.progress = progress
    
    blueDegress = [.degrees(42), .degrees(138)]
    greenDegress = [.degrees(162), .degrees(258)]
    redDegress = [.degrees(282), .degrees(378)]
    
    exerciseDegress = [.degrees(42), .degrees(Double(42 + floorf(progress[0] * maximum)))]
    activeDegress = [.degrees(162), .degrees(Double(162 + floorf(progress[1] * maximum)))]
    stepDegress = [.degrees(282), .degrees(Double(282 + floorf(progress[2] * maximum)))]
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
        .stroke(rgbColor(0xff008BE8).opacity(0.3), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: greenDegress[0],
            endAngle: greenDegress[1],
            clockwise: false
          )
        }
        .stroke(rgbColor(0xff00D48A).opacity(0.3), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: redDegress[0],
            endAngle: redDegress[1],
            clockwise: false
          )
        }
        .stroke(rgbColor(0xffFF5B18).opacity(0.3), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
        
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
        .stroke(rgbColor(0xff008BE8), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: activeDegress[0],
            endAngle: activeDegress[1],
            clockwise: false
          )
        }
        .stroke(rgbColor(0xff00D48A), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
        Path { path in
          path.addArc(
            center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
            radius: geometry.size.width / 2,
            startAngle: stepDegress[0],
            endAngle: stepDegress[1],
            clockwise: false
          )
        }
        .stroke(rgbColor(0xffFF5B18), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .miter))
      }
    }
  }
}

struct MOSmallView: View {
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        MOCricleView(progress: [0.1, 0.2, 0.3])
          .frame(width: 52, height: 52, alignment: .leading)
          .foregroundColor(.blue)
        Spacer()
      }
      Text("— /— 小时")
        .foregroundColor(rgbColor(0xff00D48A))
        .font(.system(size: 18))
      Spacer().frame(height: 4)
      Text("— /— 分钟")
        .foregroundColor(rgbColor(0xff008BE8))
        .font(.system(size: 18))
      Spacer().frame(height: 4)
      Text("2980/10000 step")
        .foregroundColor(rgbColor(0xffFF5B18))
        .font(.system(size: 18))
    }
    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
    .background(Color.gray)
  }
}
