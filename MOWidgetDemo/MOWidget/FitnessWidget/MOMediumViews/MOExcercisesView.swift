//
//  MOExcercisesView.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOExcercisesView: View {
    let exercises: [Float]
    var maximun: Float = 0.0
    
    init(exercises: [Float]) {
        self.exercises = exercises
        self.exercises.forEach { (value) in
            self.maximun = max(self.maximun, value)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(NSLocalizedString("widget.exercises", comment: "exercises"))
                .font(.caption)
            
            Spacer().frame(height:5)
            
            ZStack {
                HStack(alignment: .bottom, spacing: 0.74) {
                    ForEach(exercises.indices, id: \.self) { index in
                        // line
                        if (index % 12 == 0) {
                            VStack(spacing: 1) {
                                ForEach([0, 1, 2, 3, 4, 6, 7], id: \.self) { value in
                                    Circle()
                                        .frame(width: 1, height: 1)
                                        .foregroundColor(Color("dottedLine"))
                                }
                            }
                        }
                        // value bar
                        if (exercises[index] > 0) {
                            Capsule()
                                .fill(rgbColor(0xff008BE8))
                                .frame(width: 2, height: 13 * CGFloat((exercises[index] / self.maximun)))
                        } else {
                            Circle()
                                .frame(width: 2, height: 2)
                                .foregroundColor(rgbColor(0xff008BE8).opacity(0.3))
                        }
                    }
                }
            }
        }
        .padding(0)
    }
}

