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
  let data: MOFitnessData
  let activitiesUnits: String = NSLocalizedString("widget.activeUnits", comment: "hour")
  let exerciseUnits: String = NSLocalizedString("widget.exerciseUnits", comment: "minute")
  let stepsUnits: String = NSLocalizedString("widget.stepsUnits", comment: "step")
  var excercise: String
  var excerciseGoal: String
  var active: String
  var activeGoal: String
  var step: String
  var stepGoal: String
  init(data: MOFitnessData) {
    self.data = data
    active = data.activesNow > 0 ? "\(data.activesNow)" : "— "
    activeGoal = data.activesGoal > 0 ? "\(data.activesGoal)" : "— "
    
    excercise = data.exercisesNow > 0 ? "\(data.exercisesNow)" : "— "
    excerciseGoal = data.exercisesGoal > 0 ? "\(data.exercisesGoal)" : "— "
    
    step = data.stepsNow > 0 ? "\(data.stepsNow)" : "— "
    stepGoal = data.stepsGoal > 0 ? "\(data.stepsGoal)" : "— "
  }
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        MOCricleView(progress: data.progress())
          .frame(width: kScale() * 52, height: kScale() * 52, alignment: .leading)
          .foregroundColor(.blue)
        Spacer()
      }
      Spacer().frame(height: 16)
      HStack {
        Text("\(active)/\(activeGoal) \(activitiesUnits)")
          .foregroundColor(rgbColor(0xff00D48A))
          .font(.system(size: kScale() * 16, weight: .medium))
      }

      Spacer().frame(height: 4)
      HStack {
        Text("\(excercise)/\(excerciseGoal) \(exerciseUnits)")
          .foregroundColor(rgbColor(0xff008BE8))
          .font(.system(size: kScale() * 16, weight: .medium))
      }

      Spacer().frame(height: 4)
      HStack {
        Text("\(step)/\(stepGoal) \(stepsUnits)")
          .foregroundColor(rgbColor(0xffFF5B18))
          .font(.system(size: kScale() * 16, weight: .medium))
      }

    }
    .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
  }
}
