import SwiftUI
import SwoondCore

/// Settings (design 3h): people, Appearance (Dark / Light / System), and preferences (Discreet mode, Daily reminder,
/// Sounds & haptics). Also the doorway to Swoon'd+ and to managing people.
struct SettingsView: View {
    @Binding var path: [MeRoute]
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ScreenTitle(title: "Settings")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s8)

                SectionHeader(title: "People")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s20).padding(.bottom, SWSpace.s8)
                peopleCard

                SectionHeader(title: "Appearance")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s20).padding(.bottom, SWSpace.s8)
                SWSegmentedControl(options: AppSettings.Appearance.allCases.map { (value: $0, title: $0.title) },
                                   selection: $model.settings.appearance)
                    .padding(.horizontal, SWSpace.cardGutter)

                SectionHeader(title: "Preferences")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s20).padding(.bottom, SWSpace.s8)
                VStack(spacing: 0) {
                    ToggleRow(title: "Discreet mode", subtitle: "Hides their name in notifications and previews", isOn: $model.settings.discreetMode)
                    Divider().overlay(Color.sw.stroke)
                    ToggleRow(title: "Daily reminder", subtitle: "\(model.settings.reminderTimeLabel), before game time", isOn: $model.settings.dailyReminder)
                    if model.settings.dailyReminder {
                        Divider().overlay(Color.sw.stroke)
                        reminderTimeRow
                    }
                    Divider().overlay(Color.sw.stroke)
                    ToggleRow(title: "Sounds and haptics", subtitle: "Feedback when you answer", isOn: $model.settings.soundsAndHaptics)
                }
                .swCard(radius: SWRadius.card)
                .padding(.horizontal, SWSpace.cardGutter)

                SectionHeader(title: "Swoon\u{2019}d+")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s20).padding(.bottom, SWSpace.s8)
                plusCard

                about
            }
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    // MARK: People

    private var peopleCard: some View {
        VStack(spacing: 0) {
            ForEach(model.people) { person in
                Button { model.setActivePerson(person.id) } label: { personRow(person) }
                    .buttonStyle(.plain)
                Divider().overlay(Color.sw.stroke)
            }
            Button { model.isPresentingAddPerson = true } label: {
                HStack(spacing: SWSpace.s12) {
                    Image(systemName: "plus").font(.system(size: 16, weight: .medium)).foregroundStyle(Color.sw.accentSoft)
                        .frame(width: 38, height: 38)
                        .overlay(Circle().strokeBorder(Color.sw.accent.opacity(0.5), style: StrokeStyle(lineWidth: 1.5, dash: [3, 3])))
                    Text("Add another person").font(SWFont.ui(15, weight: .medium)).foregroundStyle(Color.sw.accentSoft)
                    Spacer()
                }
                .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
                .frame(minHeight: SWSize.minTarget)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Divider().overlay(Color.sw.stroke)
            Button { path.append(.people) } label: {
                ChevronRow {
                    Text("Manage people").font(SWFont.ui(15)).foregroundStyle(Color.sw.ink2)
                }
            }
            .buttonStyle(.plain)
        }
        .swCard(radius: SWRadius.card)
        .padding(.horizontal, SWSpace.cardGutter)
    }

    private func personRow(_ person: Person) -> some View {
        let isActive = person.id == model.activePerson?.id
        return HStack(spacing: SWSpace.s12) {
            Avatar(initial: person.displayName, size: 38, style: .person)
            VStack(alignment: .leading, spacing: 2) {
                Text(person.displayName).font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink)
                Text(interestSummary(person)).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4).lineLimit(1)
            }
            Spacer()
            if isActive { Text("Active").font(SWFont.ui(11, weight: .medium, relativeTo: .caption)).foregroundStyle(Color.sw.accentSoft) }
        }
        .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
        .frame(minHeight: SWSize.minTarget)
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(person.displayName), \(person.relationship.displayName). \(interestSummary(person)).\(isActive ? " Active." : "")")
        .accessibilityHint(isActive ? "" : "Makes this the active person")
    }

    private func interestSummary(_ person: Person) -> String {
        let names = person.interests.map { model.interestName($0.courseId) }
        return names.isEmpty ? person.relationship.displayName : names.joined(separator: ", ")
    }

    // MARK: Reminder time

    private var reminderTimeRow: some View {
        @Bindable var model = model
        return HStack {
            Text("Reminder time").font(SWFont.ui(15)).foregroundStyle(Color.sw.ink)
            Spacer()
            Picker("Reminder time", selection: $model.settings.reminderHour) {
                ForEach(0..<24, id: \.self) { hour in
                    Text(AppSettings(reminderHour: hour).reminderTimeLabel).tag(hour)
                }
            }
            .pickerStyle(.menu)
            .tint(Color.sw.ink2)
        }
        .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s6)
        .frame(minHeight: SWSize.minTarget)
    }

    // MARK: Plus and about

    private var plusCard: some View {
        Button { model.showPaywall(.settings) } label: {
            HStack(spacing: SWSpace.s12) {
                VStack(alignment: .leading, spacing: 2) {
                    Wordmark(size: 24, premium: true)
                    Text(model.learner.isPremium ? "You\u{2019}re in. Unlimited hearts, every interest." : "Unlimited hearts, every interest, live companion.")
                        .font(SWText.captionSmall).foregroundStyle(Color.sw.ink3).multilineTextAlignment(.leading)
                }
                Spacer()
                if model.learner.isPremium {
                    Pill(text: "Active", style: .reward)
                } else {
                    Image(systemName: "chevron.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color.sw.ink5)
                }
            }
            .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
            .swCard(radius: SWRadius.card)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, SWSpace.cardGutter)
    }

    private var about: some View {
        VStack(alignment: .leading, spacing: SWSpace.s6) {
            Text("Names stay on this device. Fonts: Instrument Serif and Geist, SIL Open Font License.")
            Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.1")")
        }
        .font(SWText.captionSmall).foregroundStyle(Color.sw.ink5)
        .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s24)
    }
}

/// Manage people: switch the active person or remove someone (their progress stays on the device until reinstall).
struct PeopleListView: View {
    @Environment(AppModel.self) private var model
    @State private var pendingDelete: Person?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpace.s16) {
                ScreenTitle(title: "People", subtitle: "Progress is kept per person. Common ground is measured with whoever is active.")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s8)
                VStack(spacing: SWSpace.s8) {
                    ForEach(model.people) { person in row(person) }
                }
                .padding(.horizontal, SWSpace.cardGutter)
                SecondaryButton("Add another person") { model.isPresentingAddPerson = true }
                    .padding(.horizontal, SWSpace.cardGutter)
            }
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .confirmationDialog("Remove \(pendingDelete?.displayName ?? "this person")?", isPresented: Binding(get: { pendingDelete != nil }, set: { if !$0 { pendingDelete = nil } }),
                            titleVisibility: .visible, presenting: pendingDelete) { person in
            Button("Remove", role: .destructive) { Task { await model.deletePerson(person.id) } }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("Their plan and progress with you will be removed from this phone.")
        }
    }

    private func row(_ person: Person) -> some View {
        let isActive = person.id == model.activePerson?.id
        return HStack(spacing: SWSpace.s12) {
            Button { model.setActivePerson(person.id) } label: {
                HStack(spacing: SWSpace.s12) {
                    Avatar(initial: person.displayName, size: 40, style: .person)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(person.displayName).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                        Text("\(person.relationship.displayName) \u{B7} \(person.interests.count) \(person.interests.count == 1 ? "interest" : "interests")")
                            .font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                    }
                    Spacer()
                    if isActive { Pill(text: "Active", style: .accent) }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            Button { pendingDelete = person } label: {
                Image(systemName: "trash").foregroundStyle(Color.sw.ink4).frame(width: SWSize.minTarget, height: SWSize.minTarget)
            }
            .accessibilityLabel("Remove \(person.displayName)")
        }
        .padding(.leading, SWSpace.s16).padding(.trailing, SWSpace.s4).padding(.vertical, SWSpace.s8)
        .swCard(radius: SWRadius.row)
    }
}

#Preview("Settings") {
    PreviewHost { _ in NavigationStack { SettingsView(path: .constant([])) } }
}

#Preview("Settings (light)") {
    PreviewHost(settings: AppSettings(appearance: .light)) { _ in NavigationStack { SettingsView(path: .constant([])) } }
}

#Preview("People") {
    PreviewHost { _ in NavigationStack { PeopleListView() } }
}
