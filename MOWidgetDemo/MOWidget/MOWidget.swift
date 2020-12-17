//
//  MOWidget.swift
//  MOWidget
//
//  Created by 莫晓卉 on 2020/12/11.
//
//
import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOData(number: 10))
  }

  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration, data: MOData(number: 11))
    completion(entry)
  }

  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []

    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
        let entryDate = Calendar.current.date(byAdding: .second, value: 3*hourOffset, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, configuration: configuration, data: MOData(number: hourOffset))
        entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct MOData {
  let number: Int
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  let data: MOData
}

struct MOWidgetEntryView : View {
  var entry: Provider.Entry

  @Environment(\.widgetFamily) var family
  
  var body: some View {
    switch family {
    case .systemSmall: MOSmallView()
    case .systemMedium: MOSmallView()
    default: MOSmallView()
    }
  }
}

@main
struct MOWidget: Widget {
  let kind: String = "MOWidget"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
        MOWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct MOWidget_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MOWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOData(number: 12)))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
//      MOWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), data: MOData(number: 12)))
//        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }

  }
}
