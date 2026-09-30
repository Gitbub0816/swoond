import SwiftUI
import SwoondCore

/// Learn tab root (design 2b): wordmark + streak and hearts, "Learning for {person}", common ground ring,
/// today's game, daily bite, their interests, Playbook.
struct HomeView: View {
    @Binding var path: [LearnRoute]
    @Environment(AppModel.self) private var model
    @State private var vm = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                if let person = model.activePerson {
                    personSwitcher(person)
                    ringRow(person)
                    heroSection(person)
                    biteSection(person)
                    interestsSection(person)
                    playbookRow
                } else {
                    MessageCard(title: "Add someone to get started", message: "Swoon\u{2019}d is built around a person. Add one in Settings.")
                        .padding(.horizontal, SWSpace.cardGutter)
                }
            }
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .toolbar(.hidden, for: .navigationBar)
        .task(id: model.activePerson?.id) { await vm.load(model: model) }
        .task(id: model.learner) { await vm.load(model: model) }
    }

    // MARK: Sections

    private var header: some View {
        HStack {
            Wordmark(size: 26)
            Spacer()
            HStack(spacing: SWSpace.s8) {
                StreakPill(days: model.learner.streak)
                HeartsPill(hearts: model.learner.hearts.current, isUnlimited: model.learner.hearts.isUnlimited)
            }
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s8)
    }

    private func personSwitcher(_ person: Person) -> some View {
        Menu {
            ForEach(model.people) { p in
                Button {
                    model.setActivePerson(p.id)
                } label: {
                    if p.id == person.id { Label(p.displayName, systemImage: "checkmark") } else { Text(p.displayName) }
                }
            }
            Divider()
            Button("Add another person", systemImage: "plus") { model.isPresentingAddPerson = true }
        } label: {
            HStack(spacing: 6) {
                Text("Learning for").foregroundStyle(Color.sw.ink4)
                Text(person.displayName).foregroundStyle(Color.sw.ink).fontWeight(.semibold)
                Image(systemName: "chevron.up.chevron.down").imageScale(.small).foregroundStyle(Color.sw.ink4)
            }
            .font(SWText.caption)
            .frame(minHeight: SWSize.minTarget)
            .contentShape(Rectangle())
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s4)
        .accessibilityLabel("Learning for \(person.displayName)")
        .accessibilityHint("Switch person")
    }

    private func ringRow(_ person: Person) -> some View {
        HStack(spacing: SWSpace.s18) {
            CommonGroundRing(fraction: vm.commonGround)
            VStack(alignment: .leading, spacing: SWSpace.s6) {
                Eyebrow("Common ground with")
                Text(person.displayName)
                    .swDisplay(34, lineHeight: 1.05, relativeTo: .largeTitle)
                    .foregroundStyle(Color.sw.ink)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                Text(vm.commonGroundLine).font(SWText.caption).foregroundStyle(Color.sw.ink3)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s8)
        .accessibilityElement(children: .combine)
    }

    @ViewBuilder
    private func heroSection(_ person: Person) -> some View {
        if let hero = vm.hero {
            Button {
                model.play(GameLaunch(personId: person.id, courseId: hero.courseId, kind: hero.kind))
            } label: {
                VStack(alignment: .leading, spacing: 0) {
                    Eyebrow(hero.eyebrow, color: Color.sw.accentSoft)
                    Text(hero.title)
                        .swDisplay(32, lineHeight: 1.05, relativeTo: .title)
                        .foregroundStyle(Color.sw.ink)
                        .multilineTextAlignment(.leading)
                        .padding(.top, SWSpace.s8)
                    Text(hero.subtitle)
                        .font(SWText.caption).foregroundStyle(Color.sw.ink2)
                        .multilineTextAlignment(.leading)
                        .padding(.top, SWSpace.s8)
                    HStack {
                        Text(hero.footer).font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
                        Spacer()
                        PlayPill()
                    }
                    .padding(.top, SWSpace.s18)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, SWSpace.s20)
                .padding(.vertical, SWSpace.s18)
                .swHeroCard()
            }
            .buttonStyle(.plain)
            .padding(.horizontal, SWSpace.cardGutter)
            .padding(.top, SWSpace.s16)
            .accessibilityLabel("\(hero.eyebrow). \(hero.title). \(hero.footer)")
            .accessibilityHint("Starts today\u{2019}s game")
        } else if vm.isLoaded {
            MessageCard(title: "More games are on the way",
                        message: "We\u{2019}re still writing the courses for \(person.displayName)\u{2019}s interests. Check back soon.")
                .padding(.horizontal, SWSpace.cardGutter)
                .padding(.top, SWSpace.s16)
        }
    }

    @ViewBuilder
    private func biteSection(_ person: Person) -> some View {
        if let bite = vm.dailyBite {
            Button {
                model.fullScreen = .dailyBite(courseId: bite.courseId)
            } label: {
                HStack(spacing: SWSpace.s12) {
                    VStack(alignment: .leading, spacing: SWSpace.s4) {
                        Eyebrow("Daily bite \u{B7} +\(XPValues.dailyBite) XP", color: Color.sw.reward)
                        Text(bite.headline).font(SWText.bodyL).foregroundStyle(Color.sw.ink).multilineTextAlignment(.leading)
                    }
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color.sw.ink5)
                }
                .padding(.horizontal, SWSpace.s18)
                .padding(.vertical, SWSpace.s14)
                .swCard(radius: SWRadius.row)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, SWSpace.cardGutter)
            .padding(.top, SWSpace.s10)
        }
    }

    @ViewBuilder
    private func interestsSection(_ person: Person) -> some View {
        Eyebrow("Their interests")
            .padding(.horizontal, SWSpace.textGutter)
            .padding(.top, SWSpace.s16)
        VStack(spacing: SWSpace.s6) {
            ForEach(vm.rows) { row in
                InterestRowView(row: row) {
                    if let kind = row.nextLesson {
                        model.play(GameLaunch(personId: person.id, courseId: row.id, kind: kind))
                    }
                }
            }
        }
        .padding(.horizontal, SWSpace.cardGutter)
        .padding(.top, SWSpace.s10)
    }

    private var playbookRow: some View {
        Button { path.append(.playbook) } label: {
            ChevronRow {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Playbook").font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text("Every term you\u{2019}ve met, in plain English").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                }
            }
            .swCard(radius: SWRadius.row)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, SWSpace.cardGutter)
        .padding(.top, SWSpace.s16)
    }
}

/// One interest row: monogram tile, name, progress bar, percent.
struct InterestRowView: View {
    var row: HomeViewModel.InterestRow
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: SWSpace.s14) {
                Text(verbatim: row.monogram)
                    .font(SWFont.display(20, italic: true, relativeTo: .title3))
                    .foregroundStyle(Color.sw.ink)
                    .frame(width: 38, height: 38)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.sw.ink.opacity(0.06)))
                VStack(alignment: .leading, spacing: 7) {
                    Text(row.name).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    SWProgressBar(value: row.fraction)
                }
                Text(row.hasContent ? "\(row.percent)%" : "Soon")
                    .font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
                    .frame(minWidth: 34, alignment: .trailing)
            }
            .padding(.horizontal, SWSpace.s14)
            .padding(.vertical, 9)
            .frame(minHeight: SWSize.minTarget)
            .swCard(radius: SWRadius.row)
            .opacity(row.hasContent ? 1 : 0.6)
        }
        .buttonStyle(.plain)
        .disabled(row.nextLesson == nil)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(row.name), \(row.hasContent ? "\(row.percent) percent" : "coming soon")")
        .accessibilityHint(row.nextLesson == nil ? "" : "Plays the next lesson")
    }
}

#Preview("Home") {
    PreviewHost { _ in
        NavigationStack { HomeView(path: .constant([])) }
    }
}

#Preview("Home (light)") {
    PreviewHost(settings: AppSettings(appearance: .light)) { _ in
        NavigationStack { HomeView(path: .constant([])) }
    }
}
