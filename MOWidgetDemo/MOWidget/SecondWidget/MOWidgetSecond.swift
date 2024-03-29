//
//  MOWidgetSecond.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/26.
//

import WidgetKit
import SwiftUI
import Intents

struct MOSencondProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), data: MOWidgetSecondData(number: 10))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), data: MOWidgetSecondData(number: 11))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: 3*hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, data: MOWidgetSecondData(number: hourOffset))
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MOWidgetSecondData {
    let number: Int
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: MOWidgetSecondData
}

struct MOWidgetSecondEntryView : View {
    var entry: SimpleEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        Text("\(entry.data.number)")
    }
}

struct MOWidgetSecond: Widget {
    let kind: String = "MOWidgetSecond"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MOSencondProvider()) { entry in
            MOWidgetSecondEntryView(entry: entry)
        }
        .configurationDisplayName("MOWidgetSecondName")
        .description("MOWidgetSecondDescription")
        .supportedFamilies([.systemSmall])
    }
}

struct MOWidgetSecond_Previews: PreviewProvider {
    static var previews: some View {
        MOWidgetSecondEntryView(entry: SimpleEntry(date: Date(), data: MOWidgetSecondData(number: 12)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
