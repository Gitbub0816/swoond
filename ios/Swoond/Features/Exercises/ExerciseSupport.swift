import SwiftUI
import SwoondCore

/// Everything an exercise view needs from the game shell. Views apply each answer to their own engine copy for
/// instant feedback and hand the same answer to `submit` so the `LearningSession` records XP, hearts and mastery.
@MainActor
struct ExerciseCoordinator {
    var activityId: String
    /// Display only (Talk Track header). Never logged.
    var personName: String?
    var interestName: String
    var isLast: Bool
    var submit: (ExerciseAnswer) -> Void
    var next: () -> Void

    var nextTitle: String { isLast ? "Finish" : "Continue" }
}

/// A primary in-game action ("Check", "Lock it in", "Start stop").
struct ExerciseAction {
    var title: String
    var isEnabled = true
    var perform: () -> Void
}

/// Shared exercise layout: eyebrow, Display M serif prompt, content, then (after answering) the feedback panel and
/// the pinned Continue button. Input is disabled by the views once `evaluation` is set.
struct ExerciseScaffold<Content: View, After: View>: View {
    var eyebrow: String?
    var prompt: String?
    var promptSize: CGFloat = 30
    var evaluation: ExerciseEvaluation?
    var coordinator: ExerciseCoordinator
    var action: ExerciseAction?
    var continueTitle: String?
    @ViewBuilder var content: () -> Content
    @ViewBuilder var after: () -> After

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: SWSpace.s18) {
                    if eyebrow != nil || prompt != nil {
                        VStack(alignment: .leading, spacing: SWSpace.s8) {
                            if let eyebrow { Eyebrow(eyebrow, color: Color.sw.accentSoft) }
                            if let prompt {
                                Text(prompt)
                                    .swDisplay(promptSize, lineHeight: 1.1, relativeTo: .title)
                                    .foregroundStyle(Color.sw.ink)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .accessibilityAddTraits(.isHeader)
                            }
                        }
                    }
                    content()
                    if let evaluation {
                        FeedbackPanel(evaluation: evaluation)
                            .id("feedback")
                            .transition(.opacity)
                        after()
                    }
                }
                .padding(.horizontal, SWSpace.s24)
                .padding(.top, SWSpace.s22)
                .padding(.bottom, SWSpace.s24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scrollBounceBehavior(.basedOnSize)
            .onChange(of: evaluation) { _, new in
                guard new != nil else { return }
                withAnimation(reduceMotion ? nil : .swPanel) { proxy.scrollTo("feedback", anchor: .bottom) }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) { footer }
    }

    @ViewBuilder
    private var footer: some View {
        if evaluation != nil {
            PrimaryButton(continueTitle ?? coordinator.nextTitle) { coordinator.next() }
                .padding(.horizontal, SWSpace.s20)
                .padding(.bottom, SWSize.ctaBottom)
                .padding(.top, SWSpace.s8)
        } else if let action {
            GameButton(action.title) { action.perform() }
                .disabled(!action.isEnabled)
                .padding(.horizontal, SWSpace.s20)
                .padding(.bottom, SWSize.ctaBottom)
                .padding(.top, SWSpace.s8)
        }
    }
}

extension ExerciseScaffold where After == EmptyView {
    init(eyebrow: String? = nil, prompt: String? = nil, promptSize: CGFloat = 30, evaluation: ExerciseEvaluation?,
         coordinator: ExerciseCoordinator, action: ExerciseAction? = nil, continueTitle: String? = nil,
         @ViewBuilder content: @escaping () -> Content) {
        self.init(eyebrow: eyebrow, prompt: prompt, promptSize: promptSize, evaluation: evaluation, coordinator: coordinator,
                  action: action, continueTitle: continueTitle, content: content, after: { EmptyView() })
    }
}

/// One answer row (multiple-choice, visual-id, listening-id, decision-scenario). Correct = gold border + check,
/// wrong = rose border + cross: the icon and the panel title carry the meaning, not color alone.
struct OptionRow: View {
    enum RowState { case idle, selected, correct, wrong, dimmed }

    var text: String
    var state: RowState
    var position: (index: Int, count: Int)?
    var isMultiSelect = false
    var action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button {
            Haptics.shared.selection()
            action()
        } label: {
            HStack(spacing: SWSpace.s12) {
                Text(text)
                    .font(SWFont.ui(16, weight: .medium))
                    .foregroundStyle(Color.sw.ink)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                indicator
            }
            .padding(.horizontal, SWSpace.s16)
            .padding(.vertical, SWSpace.s14)
            .frame(minHeight: 56)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(fill))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(border, lineWidth: state == .idle || state == .dimmed ? 1 : 1.5))
            .opacity(state == .dimmed ? 0.55 : 1)
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
        .animation(reduceMotion ? nil : .swTap, value: state)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText)
        .accessibilityAddTraits(state == .selected ? .isSelected : [])
    }

    @ViewBuilder
    private var indicator: some View {
        switch state {
        case .correct:
            Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.sw.reward).accessibilityHidden(true)
        case .wrong:
            Image(systemName: "xmark.circle.fill").foregroundStyle(Color.sw.accent).accessibilityHidden(true)
        case .selected:
            Image(systemName: isMultiSelect ? "checkmark.square.fill" : "largecircle.fill.circle").foregroundStyle(Color.sw.accent).accessibilityHidden(true)
        case .idle:
            Image(systemName: isMultiSelect ? "square" : "circle").foregroundStyle(Color.sw.ink5).accessibilityHidden(true)
        case .dimmed:
            EmptyView()
        }
    }

    private var fill: Color {
        switch state {
        case .selected, .wrong: return Color.sw.accentTint
        case .correct: return Color.sw.rewardTint
        default: return Color.sw.surface
        }
    }

    private var border: Color {
        switch state {
        case .selected, .wrong: return Color.sw.accent
        case .correct: return Color.sw.reward
        default: return Color.sw.strokeStrong
        }
    }

    private var accessibilityText: String {
        var parts = [text]
        if let position { parts.append("\(position.index) of \(position.count)") }
        switch state {
        case .correct: parts.append("correct answer")
        case .wrong: parts.append("your answer, incorrect")
        default: break
        }
        return parts.joined(separator: ", ")
    }
}

/// Diagonal-stripe placeholder for images that are not bundled (mirrors the design's photo placeholder).
struct StripedPlaceholder: View {
    var label: String

    var body: some View {
        ZStack {
            Canvas { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color.sw.surface))
                var x: CGFloat = -size.height
                while x < size.width {
                    var stripe = Path()
                    stripe.move(to: CGPoint(x: x, y: size.height))
                    stripe.addLine(to: CGPoint(x: x + size.height, y: 0))
                    context.stroke(stripe, with: .color(Color.sw.surface2.opacity(0.7)), lineWidth: 14)
                    x += 28
                }
            }
            Text(label)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color.sw.ink5)
        }
    }
}

/// A bundled image asset, or the striped placeholder when it is not in the build.
struct AssetImage: View {
    var asset: String
    var alt: String

    var body: some View {
        Group {
            if let url = AssetLocator.url(for: asset), let image = UIImage(contentsOfFile: url.path) {
                Image(uiImage: image).resizable().scaledToFill()
            } else {
                StripedPlaceholder(label: "[ \(asset.split(separator: "/").last.map(String.init) ?? "image") ]")
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(alt)
        .accessibilityAddTraits(.isImage)
    }
}

/// Shows an unsupported/undecodable exercise without crashing the session.
struct UnsupportedExerciseView: View {
    var typeName: String
    var coordinator: ExerciseCoordinator

    var body: some View {
        VStack(spacing: SWSpace.s16) {
            MessageCard(title: "This question is taking a break", message: "We couldn\u{2019}t show the \(typeName) exercise. You won\u{2019}t lose anything.",
                        systemImage: "exclamationmark.triangle")
            SecondaryButton("Skip it") { coordinator.next() }
        }
        .padding(SWSpace.s24)
    }
}
