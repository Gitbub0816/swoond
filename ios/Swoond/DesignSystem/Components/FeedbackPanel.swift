import SwiftUI
import SwoondCore

/// Answer feedback panel (DESIGN_SPEC section 6): 18 radius, title 15/600, explanation 13/1.45,
/// `reward-tint` when right and `accent-tint` when wrong. Color is never the only signal: the title says it too.
struct FeedbackPanel: View {
    var title: String
    var message: String
    var isPositive: Bool
    var sayThisLine: String?
    var notes: [String] = []
    /// Plays the success pulse / warning shake and the haptic when the panel appears.
    var playsEffects = true

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false
    @State private var shakes: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpace.s6) {
            Text(title).font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink)
            Text(message)
                .font(SWText.caption).lineSpacing(3)
                .foregroundStyle(Color.sw.ink2)
                .fixedSize(horizontal: false, vertical: true)
            ForEach(notes, id: \.self) { note in
                Text(note)
                    .font(SWText.caption).lineSpacing(3)
                    .foregroundStyle(Color.sw.ink3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            if let sayThisLine, !sayThisLine.isEmpty {
                Text("\u{201C}\(sayThisLine.trimmingQuotes)\u{201D}")
                    .font(SWText.displayS(19))
                    .foregroundStyle(Color.sw.ink)
                    .padding(.top, SWSpace.s4)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityLabel("You could say: \(sayThisLine.trimmingQuotes)")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, SWSpace.s16)
        .padding(.vertical, SWSpace.s14)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(isPositive ? Color.sw.rewardTint : Color.sw.accentTint))
        .scaleEffect(reduceMotion || !isPositive ? 1 : (appeared ? 1 : 1.03))
        .opacity(appeared || !reduceMotion ? 1 : 0)
        .modifier(ShakeEffect(shakes: shakes))
        .accessibilityElement(children: .combine)
        .onAppear {
            guard playsEffects else { appeared = true; return }
            if isPositive { Haptics.shared.success() } else { Haptics.shared.warning() }
            withAnimation(reduceMotion ? .swTap : .swPanel) { appeared = true }
            if !isPositive && !reduceMotion {
                withAnimation(.linear(duration: 0.3)) { shakes = 3 }
            }
        }
    }
}

extension FeedbackPanel {
    /// Build from an engine evaluation. Partial credit (score >= 50) is still shown in gold.
    init(evaluation e: ExerciseEvaluation, playsEffects: Bool = true) {
        self.init(title: e.title, message: e.explanation, isPositive: e.isCorrect || e.score >= 50,
                  sayThisLine: e.sayThisLine, notes: e.notes, playsEffects: playsEffects)
    }
}

extension String {
    /// Authors sometimes wrap lines in quotes already; the UI adds its own.
    var trimmingQuotes: String {
        trimmingCharacters(in: CharacterSet(charactersIn: "\"\u{201C}\u{201D}"))
    }
}

#Preview("Feedback") {
    VStack(spacing: 12) {
        FeedbackPanel(title: "Nice read.", message: "Two-bounce rule: the serve and the return must bounce before anyone volleys.",
                      isPositive: true, sayThisLine: "That is the two-bounce rule.", playsEffects: false)
        FeedbackPanel(title: "Not quite.", message: "Fault. The serve has to bounce first.", isPositive: false, playsEffects: false)
    }
    .padding().background(Color.sw.bg)
}
