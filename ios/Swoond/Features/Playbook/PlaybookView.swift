import SwiftUI
import SwoondCore

@MainActor
@Observable
final class PlaybookViewModel {
    private(set) var entries: [PlaybookEntry] = []
    private(set) var interests: [(id: CourseID, name: String)] = []
    var query = ""
    var courseFilter: CourseID?
    private(set) var isLoaded = false

    var visible: [PlaybookEntry] { PlaybookIndex.filter(entries, query: query, courseId: courseFilter) }
    var learnedCount: Int { PlaybookIndex.learnedCount(entries) }
    var subtitle: String {
        let n = learnedCount
        return "\(n) \(n == 1 ? "term" : "terms") learned \u{B7} \(interests.count) \(interests.count == 1 ? "interest" : "interests")"
    }

    func load(model: AppModel) async {
        guard let person = model.activePerson else { entries = []; isLoaded = true; return }
        let env = model.env
        let now = await env.engine.now()
        var curricula: [Curriculum] = []
        var masteries: [CourseID: CourseMastery] = []
        var names: [CourseID: String] = [:]
        var interestList: [(id: CourseID, name: String)] = []
        for interest in person.interests {
            let id = interest.courseId
            guard let c = try? await env.content.curriculum(courseId: id, locale: env.locale) else { continue }
            curricula.append(c)
            names[id] = model.interestName(id)
            interestList.append((id, model.interestName(id)))
            if let m = try? await env.engine.mastery(courseId: id) { masteries[id] = m }
        }
        entries = PlaybookIndex.entries(curricula: curricula, courseNames: names, mastery: masteries, now: now)
        interests = interestList
        if let f = courseFilter, !interestList.contains(where: { $0.id == f }) { courseFilter = nil }
        isLoaded = true
    }
}

/// Playbook (design 3b): every term you've met, in plain English. Search normalizes apostrophes and spacing
/// (`swoond` finds "Swoon'd").
struct PlaybookView: View {
    @Environment(AppModel.self) private var model
    @State private var vm = PlaybookViewModel()

    var body: some View {
        @Bindable var vm = vm
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ScreenTitle(title: "Playbook", subtitle: vm.subtitle)
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s8)
                searchField($vm.query)
                    .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s16)
                if vm.interests.count > 1 { filterChips }
                LazyVStack(spacing: SWSpace.s10) {
                    ForEach(vm.visible) { entry in termCard(entry) }
                }
                .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s16)
                if vm.visible.isEmpty && vm.isLoaded {
                    MessageCard(title: vm.entries.isEmpty ? "Nothing here yet" : "No matches",
                                message: vm.entries.isEmpty ? "Play a game and the terms you meet land here." : "Try a shorter search or another interest.",
                                systemImage: "magnifyingglass")
                        .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s8)
                }
            }
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
        .swBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .task(id: model.activePerson?.id) { await vm.load(model: model) }
        .task(id: model.learner) { await vm.load(model: model) }
    }

    private func searchField(_ text: Binding<String>) -> some View {
        HStack(spacing: SWSpace.s10) {
            Image(systemName: "magnifyingglass").foregroundStyle(Color.sw.ink5).accessibilityHidden(true)
            TextField("Search terms", text: text)
                .font(SWFont.ui(14)).foregroundStyle(Color.sw.ink)
                .textInputAutocapitalization(.never).autocorrectionDisabled()
                .submitLabel(.search)
            if !text.wrappedValue.isEmpty {
                Button { text.wrappedValue = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(Color.sw.ink5).frame(width: SWSize.minTarget, height: SWSize.minTarget)
                }
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.leading, SWSpace.s16)
        .frame(minHeight: 46)
        .swCard(radius: SWRadius.input, border: Color.sw.strokeStrong)
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: SWSpace.s8) {
                Chip(title: "All", isOn: vm.courseFilter == nil) { vm.courseFilter = nil }
                ForEach(vm.interests, id: \.id) { interest in
                    Chip(title: interest.name, isOn: vm.courseFilter == interest.id) { vm.courseFilter = interest.id }
                }
            }
            .padding(.horizontal, SWSpace.cardGutter)
        }
        .padding(.top, SWSpace.s12)
    }

    private func termCard(_ entry: PlaybookEntry) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                Text(entry.concept.term).font(SWText.displayS(26)).foregroundStyle(Color.sw.ink)
                Spacer(minLength: SWSpace.s8)
                statusLabel(entry.status)
            }
            Text(entry.concept.definition)
                .font(SWText.body).lineSpacing(3).foregroundStyle(Color.sw.ink2)
                .padding(.top, SWSpace.s4).fixedSize(horizontal: false, vertical: true)
            if entry.status != .new {
                Text("\u{201C}\(entry.concept.exampleLine.trimmingQuotes)\u{201D}")
                    .font(SWFont.ui(13, relativeTo: .footnote)).italic().foregroundStyle(Color.sw.ink4)
                    .padding(.top, SWSpace.s10).fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 18).padding(.vertical, SWSpace.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swCard(radius: SWRadius.card)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(entry.concept.term), \(entry.status.rawValue). \(entry.concept.definition)")
    }

    private func statusLabel(_ status: MasteryStatus) -> some View {
        HStack(spacing: 4) {
            if status == .mastered { Image(systemName: "checkmark").font(.system(size: 9, weight: .bold)).accessibilityHidden(true) }
            Text(status.rawValue)
        }
        .font(SWFont.ui(11, weight: .medium, relativeTo: .caption))
        .foregroundStyle(status == .mastered ? Color.sw.reward : Color.sw.ink3)
    }
}

#Preview("Playbook") {
    PreviewHost { _ in NavigationStack { PlaybookView() } }
}
