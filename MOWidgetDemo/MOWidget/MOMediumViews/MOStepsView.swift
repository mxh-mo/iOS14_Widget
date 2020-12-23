//
//  MOStepsView.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOStepsView: View {
  var steps: [Float]
  var maximun: Float = 0.0

  init(steps: [Float]) {
    self.steps = steps
    self.steps.forEach { (value) in
      self.maximun = max(self.maximun, value)
    }
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("步数")
        .font(.system(size: 12, weight: .medium))
      
      Spacer().frame(height:5)
      
      ZStack {
        HStack(alignment: .bottom, spacing: 0.74) {
          ForEach(steps.indices, id: \.self) { index in
            // line
            if (index % 12 == 0) {
              VStack(spacing: 1) {
                ForEach([0, 1, 2, 3, 4, 6, 7], id: \.self) { value in
                  Circle()
                    .frame(width: 1, height: 1)
                    .foregroundColor(Color.black.opacity(0.3))
                }
              }
            }
            // value bar
            if (steps[index] > 0.1) {
              Capsule()
                .fill(rgbColor(0xffFF5B18))
                .frame(width: 2, height: 13 * CGFloat((steps[index] / self.maximun)))
            } else {
              Circle()
                .frame(width: 2, height: 2)
                .foregroundColor(rgbColor(0xffFF5B18).opacity(0.3))
            }
          }
        }
      }
    }
    .padding(0)
  }
}
