//
//  MOMediumView.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOMediumView: View {
  let moves: [Bool] = [false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
  let exercise: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 133.884, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let steps: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 165.98833819241983, 0.011661807580174927, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading) {
        MOMovesView(moves: moves)
          .frame(width: 138, height: 30)
        Spacer().frame(height:10)
        MOExcerciseView(exercise: exercise)
          .frame(width: 138, height: 30)
        Spacer().frame(height:10)
        MOStepsView(steps: steps)
          .frame(width: 138, height: 30)
        MOTimeView()
      }
      .padding()
      .padding(.leading, -16)
      Spacer()
    }
  }
}

struct MOTimeView: View {
  var body: some View {
    HStack(spacing: 0) {
      Text("0时")
        .font(.system(size: 8, weight: .medium))
        .frame(width: 34.5, height: 10, alignment: .leading)
      Text("6时")
        .font(.system(size: 8, weight: .medium))
        .frame(width: 34.5, height: 10, alignment: .leading)
      Text("12时")
        .font(.system(size: 8, weight: .medium))
        .frame(width: 34.5, height: 10, alignment: .leading)
      Text("18时")
        .font(.system(size: 8, weight: .medium))
        .frame(width: 34.5, height: 10, alignment: .leading)
    }
  }
}
