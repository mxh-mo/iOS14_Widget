//
//  MOWidgetViews.swift
//  MOWidgetExtension
//
//  Created by 莫晓卉 on 2020/12/16.
//

import SwiftUI

struct Arc: Shape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment
//    path.str
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
//    path.stroke(lineWidth: 4.0)
    return path
  }
}

struct MOCricleView: View {
  
  var body: some View {
    ZStack { // 重叠视图
      Arc(startAngle: .degrees(5), endAngle: .degrees(115), clockwise: false)
        .stroke(Color.red.opacity(0.5), lineWidth: 8)
//        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round))
        .frame(width: 60, height: 60)
//        .foregroundColor(.red)
      Arc(startAngle: .degrees(125), endAngle: .degrees(235), clockwise: false)
        .stroke(Color.blue.opacity(0.5), lineWidth: 8)
//        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round))
        .frame(width: 60, height: 60)
//        .foregroundColor(.blue)
      Arc(startAngle: .degrees(245), endAngle: .degrees(355), clockwise: false)
        .stroke(Color.green.opacity(0.5), lineWidth: 8)
//        .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round))
        .frame(width: 60, height: 60)
//        .foregroundColor(.green)
    }
  }
}

func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = Angle.degrees(0) - rotationAdjustment
    let modifiedEnd = Angle.degrees(120) - rotationAdjustment

    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)

    return path
}

struct MOSmallView: View {
  
  var body: some View {
    VStack {
      HStack {
        MOCricleView()
          .frame(width: 52, height: 52, alignment: .leading)
          .foregroundColor(.blue)
//          .background(Color.green)
        Spacer()
      }
//      .background(Color.yellow)
      
      HStack {
        Text("--/--小时")
          .foregroundColor(.green)
          .font(.system(Font.TextStyle.body))
          .padding([.trailing])
        Spacer()
      }
//      .background(Color.yellow)
      
      HStack {
        Text("--/--分钟")
          .foregroundColor(.blue)
          .font(.system(Font.TextStyle.body))
        Spacer()
      }
//      .background(Color.yellow)
      
      HStack {
        Text("--/--步")
          .foregroundColor(.red)
          .font(.system(Font.TextStyle.body))
        Spacer()
      }
//      .background(Color.yellow)

//      Text(entry.date, style: .time).font(.system(size: 10))
//      Text("\(entry.data.number)").font(.system(size: 10))

    }
    .padding()
    .alignmentGuide(.leading, computeValue: { dimension in
      dimension[.leading]
    })
    .background(Color.gray)
  }
}
