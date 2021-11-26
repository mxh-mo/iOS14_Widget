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
    
    /// 占位视图
    func placeholder(in context: Context) -> MOSimpleEntry {
        let size: CGSize = context.displaySize;
        print("placeholder \(size)")
        return MOSimpleEntry(date: Date(), configuration: DeviceSelectionIntent(), data: MOFitnessData())
    }
    
    /// 快照：小组件库里的显示
    func getSnapshot(for configuration: DeviceSelectionIntent, in context: Context, completion: @escaping (MOSimpleEntry) -> ()) {
        let size: CGSize = context.displaySize;
        print("getSnapshot \(size)")
        let entry = MOSimpleEntry(date: Date(), configuration: configuration, data: MOFitnessData())
        completion(entry)
    }
    
    /// 在这个方法内可以进行网络请求，拿到的数据保存在对应的entry中，调用completion之后会到刷新小组件
    func getTimeline(for configuration: DeviceSelectionIntent, in context: Context, completion: @escaping (Timeline<MOSimpleEntry>) -> ()) {
        let size: CGSize = context.displaySize;
        print("getTimeline \(size)")
        print("getTimeline deviceType: \(configuration.device.rawValue)")
        
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
    let configuration: DeviceSelectionIntent
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
        IntentConfiguration(kind: kind, intent: DeviceSelectionIntent.self, provider: Provider()) { entry in
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
                MOWidgetEntryView(entry: MOSimpleEntry(date: Date(), configuration: DeviceSelectionIntent(), data: MOFitnessData()))
                  .previewContext(WidgetPreviewContext(family: .systemSmall)) // family
                  .previewDevice(PreviewDevice(rawValue: deviceName)) // 显示的设备
                
                MOWidgetEntryView(entry: MOSimpleEntry(date: Date(), configuration: DeviceSelectionIntent(), data: MOFitnessData()))
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
//        MOWidgetSecond()
    }
}
