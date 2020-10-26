import Foundation

extension Date {

    static func set(_ date: Date = Date(),
                    calendar: Calendar = .current,
                    year: Int? = nil,
                    month: Int? = nil,
                    day: Int? = nil,
                    hour: Int? = nil,
                    minute: Int? = nil,
                    second: Int? = nil) -> Date? {
        let components = Set<Calendar.Component>(arrayLiteral: .year, .month, .day, .hour, .minute, .second)
        var dateComponents = calendar.dateComponents(components, from: date)

        dateComponents.year = year ?? dateComponents.year
        dateComponents.month = month ?? dateComponents.month
        dateComponents.day = day ?? dateComponents.day
        dateComponents.hour = hour ?? dateComponents.hour
        dateComponents.minute = minute ?? dateComponents.minute
        dateComponents.second = second ?? dateComponents.second

        return calendar.date(from: dateComponents)
    }

}
