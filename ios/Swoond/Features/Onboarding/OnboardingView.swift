import SwiftUI
import SwoondCore

/// Onboarding (design 2a, generalized to 3 steps): who are you learning for (name + relationship) -> interests -> plan.
/// Also used as the "Add person" sheet from Settings (`mode == .addPerson`).
struct OnboardingView: View {
    enum Mode { case firstRun, addPerson }

    var mode: Mode
    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var draft = OnboardingDraft()
    @State private var isSaving = false
    @FocusState private var nameFocused: Bool

    private static let relationships: [Relationship] = [.crush, .datingPartner, .friend, .familyMember, .coworker, .other]

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    switch draft.step {
                    case .person: personStep
                    case .interests: interestsStep
                    case .plan: planStep
                    }
                }
                .padding(.horizontal, SWSpace.s24)
                .padding(.top, SWSpace.s20)
                .padding(.bottom, SWSpace.s24)
                .id(draft.step)
                .transition(.opacity)
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollDismissesKeyboard(.interactively)
            footer
        }
        .swBackground()
        .animation(reduceMotion ? nil : .swPanel, value: draft.step)
    }

    // MARK: Chrome

    private var header: some View {
        VStack(spacing: SWSpace.s12) {
            HStack {
                if draft.step != .person {
                    Button { draft.back() } label: {
                        Image(systemName: "chevron.left").font(.system(size: 16, weight: .semibold))
                            .frame(width: SWSize.minTarget, height: SWSize.minTarget)
                    }
                    .foregroundStyle(Color.sw.ink2)
                    .accessibilityLabel("Back")
                } else if mode == .addPerson {
                    Button("Cancel") { model.isPresentingAddPerson = false }
                        .font(SWText.bodyLMedium)
                        .foregroundStyle(Color.sw.ink3)
                        .frame(minHeight: SWSize.minTarget)
                } else {
                    Color.clear.frame(width: SWSize.minTarget, height: SWSize.minTarget)
                }
                Spacer()
            }
            SegmentedProgress(count: OnboardingDraft.stepCount, filled: draft.stepNumber)
        }
        .padding(.horizontal, SWSpace.s24)
        .padding(.top, SWSpace.s8)
    }

    private var footer: some View {
        VStack(spacing: SWSpace.s12) {
            if draft.step == .interests {
                Text(draft.selectionLabel).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
            }
            PrimaryButton(ctaTitle) { advance() }
                .disabled(!draft.canAdvance || isSaving)
        }
        .padding(.horizontal, SWSpace.s24)
        .padding(.top, SWSpace.s12)
        .padding(.bottom, SWSize.ctaBottom)
    }

    private var ctaTitle: String {
        switch draft.step {
        case .person: return "Continue"
        case .interests: return "Build my plan"
        case .plan: return draft.trimmedName.isEmpty ? "Let\u{2019}s go" : "Start with \(draft.trimmedName)"
        }
    }

    private func advance() {
        if draft.step == .plan {
            isSaving = true
            Task {
                await model.addPerson(from: draft)
                isSaving = false
            }
        } else {
            nameFocused = false
            draft.advance()
        }
    }

    // MARK: Step 1: who

    private var personStep: some View {
        VStack(alignment: .leading, spacing: SWSpace.s10) {
            Eyebrow("Step 1 of 3")
            Text.emphasized("Who are you learning ", "for", "?", size: 42)
                .font(SWFont.display(42, relativeTo: .largeTitle))
                .foregroundStyle(Color.sw.ink)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, SWSpace.s4)
            Text("Their name stays on this device. While Discreet mode is on it never appears in a notification.")
                .font(SWText.body).foregroundStyle(Color.sw.ink3).lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            TextField("Their first name", text: $draft.name)
                .focused($nameFocused)
                .textContentType(.givenName)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                .submitLabel(.continue)
                .onSubmit { if draft.canAdvance { advance() } }
                .font(SWFont.ui(17, weight: .medium))
                .foregroundStyle(Color.sw.ink)
                .padding(.horizontal, SWSpace.s16)
                .frame(minHeight: 52)
                .swCard(radius: SWRadius.input, border: Color.sw.strokeStrong)
                .padding(.top, SWSpace.s20)

            Eyebrow("How do you know them?").padding(.top, SWSpace.s24)
            FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                ForEach(Self.relationships, id: \.self) { r in
                    Chip(title: r.displayName, isOn: draft.relationship == r) { draft.relationship = r }
                }
            }
            .padding(.top, SWSpace.s4)
        }
    }

    // MARK: Step 2: interests

    private var interestsStep: some View {
        VStack(alignment: .leading, spacing: SWSpace.s10) {
            Eyebrow("Step 2 of 3")
            Text.emphasized("What\u{2019}s ", draft.trimmedName.isEmpty ? "they" : draft.trimmedName, " into?", size: 42)
                .font(SWFont.display(42, relativeTo: .largeTitle))
                .foregroundStyle(Color.sw.ink)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, SWSpace.s4)
            Text("Pick everything. We\u{2019}ll build a plan so you\u{2019}re not nodding along blankly.")
                .font(SWText.body).foregroundStyle(Color.sw.ink3).lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
            FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                ForEach(InterestCatalog.launch) { option in
                    Chip(title: option.name, isOn: draft.isSelected(option.id)) { draft.toggle(option.id) }
                }
            }
            .padding(.top, SWSpace.s12)
        }
    }

    // MARK: Step 3: plan

    private var planStep: some View {
        VStack(alignment: .leading, spacing: SWSpace.s10) {
            Eyebrow("Step 3 of 3")
            Text.emphasized("Here\u{2019}s your ", "plan", ".", size: 42)
                .font(SWFont.display(42, relativeTo: .largeTitle))
                .foregroundStyle(Color.sw.ink)
                .padding(.top, SWSpace.s4)
            Text("Three minutes a day. Each interest teaches the words, the rules, then the conversation.")
                .font(SWText.body).foregroundStyle(Color.sw.ink3).lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: SWSpace.s18) {
                CommonGroundRing(fraction: 0, size: 88)
                VStack(alignment: .leading, spacing: SWSpace.s4) {
                    Eyebrow("Common ground with")
                    Text(draft.trimmedName).font(SWText.displayM(30)).foregroundStyle(Color.sw.ink)
                    Text("Starts at zero. That\u{2019}s the fun part.").font(SWText.caption).foregroundStyle(Color.sw.ink3)
                }
            }
            .padding(.top, SWSpace.s16)

            Eyebrow("Their interests \u{B7} tap one to make it the main one").padding(.top, SWSpace.s20)
            VStack(spacing: SWSpace.s6) {
                ForEach(draft.selectedCourseIds, id: \.self) { id in
                    planRow(id)
                    branchChips(id)
                }
            }
            .padding(.top, SWSpace.s4)
        }
    }

    /// Courses with branches (e.g. NFL vs college football) let you say which one they follow.
    @ViewBuilder
    private func branchChips(_ courseId: CourseID) -> some View {
        if let branches = model.courses.first(where: { $0.courseId == courseId })?.branches, !branches.isEmpty {
            VStack(alignment: .leading, spacing: SWSpace.s6) {
                Eyebrow("Which one do they follow?").padding(.leading, SWSpace.s4)
                FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                    Chip(title: "Not sure", isOn: draft.branchByCourse[courseId] == nil) { draft.setBranch(nil, for: courseId) }
                    ForEach(branches, id: \.id) { branch in
                        Chip(title: branch.displayName, isOn: draft.branchByCourse[courseId] == branch.id) { draft.setBranch(branch.id, for: courseId) }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, SWSpace.s6)
        }
    }

    private func planRow(_ courseId: CourseID) -> some View {
        let isMain = (draft.mainInterestId ?? draft.selectedCourseIds.first) == courseId
        let available = model.hasContent(courseId: courseId)
        return Button {
            Haptics.shared.selection()
            draft.setMain(courseId)
        } label: {
            HStack(spacing: SWSpace.s14) {
                Text(verbatim: InterestCatalog.monogram(for: courseId))
                    .font(SWFont.display(20, italic: true, relativeTo: .title3))
                    .foregroundStyle(Color.sw.ink)
                    .frame(width: 38, height: 38)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.sw.ink.opacity(0.06)))
                VStack(alignment: .leading, spacing: 2) {
                    Text(InterestCatalog.displayName(for: courseId)).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text(available ? "3 min a day" : "Coming soon").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                }
                Spacer()
                if isMain { Pill(text: "Main", style: .reward) }
            }
            .padding(.horizontal, SWSpace.s14)
            .padding(.vertical, 9)
            .frame(minHeight: SWSize.minTarget)
            .swCard(radius: SWRadius.row)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(InterestCatalog.displayName(for: courseId))\(isMain ? ", main interest" : "")\(available ? "" : ", coming soon")")
        .accessibilityHint("Makes this the main interest, which counts double toward common ground.")
    }
}

#Preview("Onboarding") {
    PreviewHost(people: []) { _ in OnboardingView(mode: .firstRun) }
}

#Preview("Onboarding (add person)") {
    PreviewHost { _ in OnboardingView(mode: .addPerson) }
}
