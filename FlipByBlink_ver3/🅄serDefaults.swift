import Foundation

enum 🅄serDefaults {
    private static var api: UserDefaults { .standard }
}

extension 🅄serDefaults {
    static var isRealPreviewEnabled: Bool { Self.api.bool(forKey: "👤🧑‍💼 Real Preview") }
    static var isPreviewHidden: Bool { Self.api.bool(forKey: "👤🚫 Hide Preview") }
    static var isPreviewAlwaysVisible: Bool { Self.api.bool(forKey: "👤🔁 Always Preview") }
    static var isShareInfoDisplayed: Bool { Self.api.bool(forKey: "🏁 Display share-info") }
    static var isRTL: Bool { Self.api.bool(forKey: "⬅️ From right-to-left") }
    
    static var isMultiPagesEnabled: Bool { Self.api.bool(forKey: "📖 Multi pages") }
    static var isFirstPageDisplayedAsSinglePage: Bool { Self.api.bool(forKey: "📙 Display the first page as a single page") }
    
    static var blinkDurationSecond: String? { Self.api.string(forKey: "🎚😑second") }
    static var isOneEyeBlinkEnabled: Bool { Self.api.bool(forKey: "😉 return") }
    
    static var bookmarkNumber: Int { Self.api.integer(forKey: "🔖") }
    static func setBookmarkNumber(_ value: Int) { Self.api.set(value, forKey: "🔖") }
}
