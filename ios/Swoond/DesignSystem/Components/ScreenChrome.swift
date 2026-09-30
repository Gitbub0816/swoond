import SwiftUI

/// Serif screen title with an optional caption ("Playbook" / "84 terms learned").
struct ScreenTitle: View {
    var title: String
    var subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpace.s6) {
            Text(title)
                .swDisplay(40, lineHeight: 1, relativeTo: .largeTitle)
                .foregroundStyle(Color.sw.ink)
                .accessibilityAddTraits(.isHeader)
            if let subtitle {
                Text(subtitle).font(SWText.caption).foregroundStyle(Color.sw.ink3)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Section label with an optional trailing value ("Badges" ... "5 / 12").
struct SectionHeader: View {
    var title: String
    var trailing: String?

    var body: some View {
        HStack {
            Eyebrow(title)
            Spacer()
            if let trailing { Eyebrow(trailing) }
        }
    }
}

/// A row that sits inside a grouped card: leading content, trailing chevron.
struct ChevronRow<Leading: View>: View {
    @ViewBuilder var leading: () -> Leading

    var body: some View {
        HStack(spacing: SWSpace.s12) {
            leading()
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.sw.ink5)
                .accessibilityHidden(true)
        }
        .padding(.horizontal, SWSpace.s16)
        .padding(.vertical, SWSpace.s14)
        .frame(minHeight: SWSize.minTarget)
        .contentShape(Rectangle())
    }
}

/// Inline error / empty message card.
struct MessageCard: View {
    var title: String
    var message: String
    var systemImage = "sparkles"

    var body: some View {
        Card {
            HStack(alignment: .top, spacing: SWSpace.s12) {
                Image(systemName: systemImage).foregroundStyle(Color.sw.reward).accessibilityHidden(true)
                VStack(alignment: .leading, spacing: SWSpace.s4) {
                    Text(title).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text(message).font(SWText.caption).foregroundStyle(Color.sw.ink3).fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

/// Close (X) button, 44 pt target.
struct CloseButton: View {
    var label = "Close"
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.sw.ink3)
                .frame(width: SWSize.minTarget, height: SWSize.minTarget)
                .contentShape(Rectangle())
        }
        .accessibilityLabel(label)
    }
}

#Preview("Chrome") {
    VStack(alignment: .leading, spacing: 16) {
        ScreenTitle(title: "Playbook", subtitle: "84 terms learned \u{B7} 3 interests")
        SectionHeader(title: "Badges", trailing: "5 / 12")
        MessageCard(title: "More games are on the way", message: "This interest is still being written.")
        CloseButton {}
    }
    .padding().background(Color.sw.bg)
}
