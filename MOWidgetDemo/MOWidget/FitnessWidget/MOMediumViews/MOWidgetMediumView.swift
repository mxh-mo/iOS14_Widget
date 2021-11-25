//
//  MOMediumView.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOMediumView: View {
    let activities: [Bool]
    let exercises: [Float]
    let steps: [Float]
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Link(destination: URL(string: "mo.activitiesView.link")!) {
                    MOActivitiesView(activities: activities)
                        .frame(height: 30)
                }
                
                Spacer().frame(height:10)
                Link(destination: URL(string: "mo.excercisesView.link")!) {
                    MOExcercisesView(exercises: exercises)
                        .frame(height: 30)
                }
                Spacer().frame(height:10)
                Link(destination: URL(string: "mo.stepsView.link")!) {
                    MOStepsView(steps: steps)
                        .frame(height: 30)
                }
                Link(destination: URL(string: "mo.timeView.link")!) {
                    MOTimeView()
                }
            }
            .padding()
            .padding(.leading, -16)
            Spacer()
        }
    }
}

struct MOTimeView: View {
    let timeUnits: String = NSLocalizedString("widget.timeUnits", comment: "时")
    var body: some View {
        HStack(spacing: 0) {
            Text("0\(timeUnits)")
                .font(.caption2)
                .frame(width: 34.5, height: 10, alignment: .leading)
            Text("6\(timeUnits)")
                .font(.caption2)
                .frame(width: 34.5, height: 10, alignment: .leading)
            Text("12\(timeUnits)")
                .font(.caption2)
                .frame(width: 34.5, height: 10, alignment: .leading)
            Text("18\(timeUnits)")
                .font(.caption2)
                .frame(width: 34.5, height: 10, alignment: .leading)
        }
    }
}
