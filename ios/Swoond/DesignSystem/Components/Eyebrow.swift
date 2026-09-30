import SwiftUI

/// Section label: 11 pt, +0.14em tracking, uppercase (the only place 11 pt text is allowed).
struct Eyebrow: View {
    var text: String
    var color: Color = Color.sw.ink4

    init(_ text: String, color: Color = Color.sw.ink4) { self.text = text; self.color = color }

    var body: some View {
        Text(text)
            .font(SWText.eyebrow)
            .tracking(1.54)
            .textCase(.uppercase)
            .foregroundStyle(color)
            .accessibilityAddTraits(.isHeader)
    }
}

#Preview("Eyebrow") {
    VStack(alignment: .leading) {
        Eyebrow("Their interests")
        Eyebrow("Today\u{2019}s game \u{B7} NASCAR", color: Color.sw.accentSoft)
    }
    .padding().background(Color.sw.bg)
}
