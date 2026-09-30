import SwiftUI

/// "Swoon" + italic accent "'d" (+ gold "+" for Swoon'd+). DESIGN_SPEC section 1.
struct Wordmark: View {
    var size: CGFloat = 26
    var premium = false

    var body: some View {
        let tail = Text(verbatim: "\u{2019}d").font(SWFont.display(size, italic: true)).foregroundStyle(Color.sw.accent)
        let plus = Text(verbatim: "+").font(SWFont.display(size)).foregroundStyle(Color.sw.reward)
        Group {
            if premium {
                Text("Swoon\(tail)\(plus)")
            } else {
                Text("Swoon\(tail)")
            }
        }
        .font(SWFont.display(size, relativeTo: .title))
        .foregroundStyle(Color.sw.ink)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(premium ? "Swoon\u{2019}d Plus" : "Swoon\u{2019}d")
    }
}

#Preview("Wordmark") {
    VStack(alignment: .leading, spacing: 16) {
        Wordmark(size: 26)
        Wordmark(size: 46, premium: true)
    }
    .padding()
    .background(Color.sw.bg)
}
