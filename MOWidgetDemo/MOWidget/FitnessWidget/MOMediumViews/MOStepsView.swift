//
//  MOStepsView.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOStepsView: View {
  var steps: [Float]
  let maxHeight: CGFloat = kScale * 13.0
  var maximun: Float = 0.0

  init(steps: [Float]) {
    self.steps = steps
    self.steps.forEach { (value) in
      self.maximun = max(self.maximun, value)
    }
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(NSLocalizedString("widget.steps", comment: "steps"))
        .font(.caption)

      Spacer().frame(height:5)
      
      ZStack {
        HStack(alignment: .bottom, spacing: 0.74) {
          ForEach(steps.indices, id: \.self) { index in
            // line
            if (index % 12 == 0) {
              VStack(spacing: 1) {
                ForEach([0, 1, 2, 3, 4, 6, 7], id: \.self) { value in
                  Circle()
                    .frame(width: kScale * 1, height: kScale * 1)
                    .foregroundColor(Color("dottedLine"))
                }
              }
            }
            // value bar
            if (steps[index] > 0.1) {
              Capsule()
                .fill(rgbColor(0xffFF5B18))
                .frame(width: kScale * 2, height: maxHeight * CGFloat((steps[index] / self.maximun)))
            } else {
              Circle()
                .frame(width: kScale * 2, height: kScale * 2)
                .foregroundColor(rgbColor(0xffFF5B18).opacity(0.3))
            }
          }
        }
      }
    }
    .padding(0)
  }
}
