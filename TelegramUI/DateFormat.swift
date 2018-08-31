import Foundation

func stringForShortTimestamp(hours: Int32, minutes: Int32, timeFormat: PresentationTimeFormat) -> String {
    switch timeFormat {
        case .regular:
            let hourString: String
            if hours == 0 {
                hourString = "12"
            } else if hours > 12 {
                hourString = "\(hours - 12)"
            } else {
                hourString = "\(hours)"
            }
            
            let periodString: String
            if hours >= 12 {
                periodString = "PM"
            } else {
                periodString = "AM"
            }
            if minutes >= 10 {
                return "\(hourString):\(minutes) \(periodString)"
            } else {
                return "\(hourString):0\(minutes) \(periodString)"
            }
        case .military:
            return String(format: "%02d:%02d", arguments: [Int(hours), Int(minutes)])
    }
}

func stringForMessageTimestamp(timestamp: Int32, timeFormat: PresentationTimeFormat) -> String {
    var t = Int(timestamp)
    var timeinfo = tm()
    localtime_r(&t, &timeinfo)
    
    return stringForShortTimestamp(hours: timeinfo.tm_hour, minutes: timeinfo.tm_min, timeFormat: timeFormat)
}

func stringForFullDate(timestamp: Int32, strings: PresentationStrings, timeFormat: PresentationTimeFormat) -> String {
    var t: time_t = Int(timestamp)
    var timeinfo = tm()
    localtime_r(&t, &timeinfo);
    
    switch timeinfo.tm_mon + 1 {
        case 1:
            return strings.Time_PreciseDate_m1("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 2:
            return strings.Time_PreciseDate_m2("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 3:
            return strings.Time_PreciseDate_m3("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 4:
            return strings.Time_PreciseDate_m4("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 5:
            return strings.Time_PreciseDate_m5("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 6:
            return strings.Time_PreciseDate_m6("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 7:
            return strings.Time_PreciseDate_m7("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 8:
            return strings.Time_PreciseDate_m8("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 9:
            return strings.Time_PreciseDate_m9("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 10:
            return strings.Time_PreciseDate_m10("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 11:
            return strings.Time_PreciseDate_m11("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        case 12:
            return strings.Time_PreciseDate_m12("\(timeinfo.tm_mday)", "\(2000 + timeinfo.tm_year - 100)", stringForShortTimestamp(hours: Int32(timeinfo.tm_hour), minutes: Int32(timeinfo.tm_min), timeFormat: timeFormat)).0
        default:
            return ""
    }
}

func stringForDate(timestamp: Int32, strings: PresentationStrings) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .medium
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = localeWithStrings(strings)
    return formatter.string(from: Date(timeIntervalSince1970: Double(timestamp)))
}

func stringForDateWithoutYear(date: Date, strings: PresentationStrings) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = localeWithStrings(strings)
    formatter.setLocalizedDateFormatFromTemplate("MMMMd")
    return formatter.string(from: date)
}

func roundDateToDays(_ timestamp: Int32) -> Int32 {
    let calendar = Calendar(identifier: .gregorian)
    var components = calendar.dateComponents(Set([.era, .year, .month, .day]), from: Date(timeIntervalSince1970: Double(timestamp)))
    components.hour = 0
    components.minute = 0
    components.second = 0
    
    guard let date = calendar.date(from: components) else {
        assertionFailure()
        return timestamp
    }
    return Int32(date.timeIntervalSince1970)
}
