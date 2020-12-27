//
//  MOActivitiesView.swift
//  MOWidgetExtension
//
//  Created by 莫晓卉 on 2020/12/23.
//

import SwiftUI

struct MOActivitiesView: View {
  var activities: [Bool]
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .leading, spacing: 0) {
        Text(NSLocalizedString("widget.actives", comment: "actives"))
          .font(.caption)
        
        Spacer().frame(height:5)
        
        HStack(spacing: 0.5) {
          
          ForEach(activities.indices, id: \.self) { index in
            if (index % 6 == 0) {
              // line
              VStack(spacing: 1) {
                ForEach([0, 1, 2], id: \.self) { value in
                  Circle()
                    .frame(width: kScale * 1, height: kScale * 1)
                    .foregroundColor(Color("dottedLine"))
                }
              }
            }
            // value point
            Circle()
              .frame(width: kScale * 5, height: kScale * 5)
              .foregroundColor(rgbColor(0xff00D48A).opacity(activities[index] ? 1 : 0.3))
          }
        }
      }
      .padding(0)
    }
  }
}
