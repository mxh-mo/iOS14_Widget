//
//  MOWidgetFitness.swift
//  MOWidgetFitness
//
//  Created by 莫晓卉 on 2020/12/11.
//
//
import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> MOSimpleEntry {
    return MOSimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOFitnessData())
  }

  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MOSimpleEntry) -> ()) {
    let entry = MOSimpleEntry(date: Date(), configuration: configuration, data: MOFitnessData())
    completion(entry)
  }

  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<MOSimpleEntry>) -> ()) {
    var entries: [MOSimpleEntry] = []
    let currentDate = Date()
    let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
    MODataSouce.shared.fetchData { (data) in
      // 请求成功
      let entry = MOSimpleEntry(date: entryDate, configuration: configuration, data: data)
      entries.append(entry)
      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    } fetchFailure: {
      // 请求失败
      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    }
  }
}

struct MOData {
  let offset: Int
}

struct MOSimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  let data: MOFitnessData
}

struct MOWidgetEntryView : View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var family
  
  var body: some View {
    switch family {
    case .systemSmall:
      MOSmallView(data: MOFitnessData())
        .widgetURL(URL(string: "mo.widget.small"))
    case .systemMedium:
      GeometryReader { geometry in
        HStack {
          MOSmallView(data: MOFitnessData())
            .frame(width: geometry.size.width/2, height: geometry.size.height)
          MOMediumView(activities: MOFitnessData().actives,
                       exercises: MOFitnessData().exercises,
                       steps: MOFitnessData().steps)
            .frame(width: geometry.size.width/2, height: geometry.size.height)
        }
        .widgetURL(URL(string: "mo.widget.medium"))
      }
    default: MOSmallView(data: MOFitnessData())
    }
  }
}

//@main
struct MOWidgetFitness: Widget {
  let kind: String = "MOWidgetFitness"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
        MOWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("widget.name")
    .description("widget.description")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct MOFitnessWidget_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach(["iPhone 12 mini", "iPhone 12", "iPhone 12 Pro Max"], id: \.self) { deviceName in
//        MOWidgetEntryView(entry: MOSimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOFitnessData()))
//          .previewContext(WidgetPreviewContext(family: .systemSmall))
//          .previewDevice(PreviewDevice(rawValue: deviceName))
        
        MOWidgetEntryView(entry: MOSimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOFitnessData()))
          .previewContext(WidgetPreviewContext(family: .systemMedium))
          .previewDevice(PreviewDevice(rawValue: deviceName))
      }
    }
  }
}

@main
struct MOWigets: WidgetBundle {
  var body: some Widget {
    MOWidgetFitness()
    MOWidgetSecond()
  }
}
