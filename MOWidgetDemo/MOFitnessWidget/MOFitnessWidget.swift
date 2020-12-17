//
//  MOFitnessWidget.swift
//  MOFitnessWidget
//
//  Created by 莫晓卉 on 2020/12/10.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MOFitnessWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            Text(entry.date, style: .time)
                .foregroundColor(.green)
        case .systemMedium:
            Text(entry.date, style: .time)
                .foregroundColor(.blue)
        default:
            Text(entry.date, style: .time)
                .foregroundColor(.blue)
        }
    }
}

@main
struct MOFitnessWidget: Widget {
    let kind: String = "MOFitnessWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MOFitnessWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MOFitnessWidget_Previews: PreviewProvider {
    static var previews: some View {
        MOFitnessWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
