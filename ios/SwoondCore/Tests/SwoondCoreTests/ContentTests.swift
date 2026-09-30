import Foundation
import Testing
@testable import SwoondCore

/// Lays out `<root>/<courseId>/{manifest.json, curriculum/en-US.json}` from the docs examples.
private func makeContentRoot() throws -> URL {
    let root = Fixtures.tempDir()
    let course = root.appendingPathComponent("american-football")
    try FileManager.default.createDirectory(at: course.appendingPathComponent("curriculum"), withIntermediateDirectories: true)
    try FileManager.default.copyItem(at: Fixtures.manifestURL, to: course.appendingPathComponent("manifest.json"))
    try FileManager.default.copyItem(at: Fixtures.curriculumURL, to: course.appendingPathComponent("curriculum/en-US.json"))
    return root
}

@Suite("BundledContentRepository")
struct BundledContentTests {
    @Test func loadsFromFlatExampleFiles() async throws {
        let repo = BundledContentRepository(locations: [.init(manifestURL: Fixtures.manifestURL, curriculumURLs: [Fixtures.curriculumURL])])
        let index = try await repo.courseIndex()
        #expect(index.map(\.courseId) == ["american-football"] && index[0].displayName == "American Football")
        #expect(index[0].branches.map(\.id) == ["nfl", "college-football"])
        #expect(try await repo.manifest(courseId: "american-football").wave == 1)
        let c = try await repo.curriculum(courseId: "american-football", locale: "en-US")
        #expect(c.units.count == 2)
    }

    @Test func discoversCourseDirectories() async throws {
        let root = try makeContentRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        let repo = try BundledContentRepository(rootDirectory: root)
        #expect(try await repo.courseIndex().count == 1)
        #expect(try await repo.curriculum(courseId: "american-football", locale: "en").concepts.count == 6)
    }

    @Test func ignoresFoldersWithoutManifest() async throws {
        let root = try makeContentRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        try FileManager.default.createDirectory(at: root.appendingPathComponent("empty-course"), withIntermediateDirectories: true)
        #expect(try await BundledContentRepository(rootDirectory: root).courseIndex().count == 1)
    }

    @Test func unknownCourseThrows() async throws {
        let repo = BundledContentRepository(locations: [.init(manifestURL: Fixtures.manifestURL, curriculumURLs: [Fixtures.curriculumURL])])
        await #expect(throws: ContentError.courseNotFound("nope")) { try await repo.manifest(courseId: "nope") }
        await #expect(throws: ContentError.courseNotFound("nope")) { try await repo.curriculum(courseId: "nope", locale: "en-US") }
    }

    @Test func missingFileThrows() async throws {
        let repo = BundledContentRepository(locations: [.init(manifestURL: Fixtures.docs("does/not/exist.json"), curriculumURLs: [])])
        await #expect(throws: ContentError.self) { try await repo.courseIndex() }
    }

    @Test func manifestWithoutCurriculumThrows() async throws {
        let repo = BundledContentRepository(locations: [.init(manifestURL: Fixtures.manifestURL, curriculumURLs: [])])
        await #expect(throws: ContentError.curriculumNotFound("american-football")) { try await repo.curriculum(courseId: "american-football", locale: "en-US") }
    }

    @Test func localeSelectionPrefersExactThenLanguage() throws {
        var us = try Fixtures.curriculum(); us.locale = "en-US"
        var gb = us; gb.locale = "en-GB"
        var es = us; es.locale = "es-ES"
        #expect(BundledContentRepository.best([us, gb, es], for: "en-GB").locale == "en-GB")
        #expect(BundledContentRepository.best([us, gb, es], for: "es").locale == "es-ES")
        #expect(BundledContentRepository.best([us, gb, es], for: "en-AU").locale == "en-US")
        #expect(BundledContentRepository.best([us, es], for: "fr").locale == "en-US")
    }
}

@Suite("ContentValidator")
struct ContentValidatorTests {
    @Test func exampleCurriculumIsClean() throws {
        let issues = ContentValidator.validate(try Fixtures.curriculum())
        #expect(issues.isEmpty, "\(issues)")
    }

    @Test func manifestAndCurriculumAgree() throws {
        #expect(ContentValidator.validate(manifest: try Fixtures.manifest(), curriculum: try Fixtures.curriculum()).isEmpty)
    }

    @Test func detectsUnknownConceptAndPrerequisite() throws {
        var c = try Fixtures.curriculum()
        c.units[1].prerequisiteUnitIds = ["ghost-unit"]
        c.units[0].lessons[0].conceptIds = ["ghost-concept"]
        let issues = ContentValidator.validate(c).map(\.message)
        #expect(issues.contains { $0.contains("ghost-unit") })
        #expect(issues.contains { $0.contains("ghost-concept") })
    }

    @Test func detectsDuplicateIds() throws {
        var c = try Fixtures.curriculum()
        c.units[0].lessons.append(c.units[0].lessons[0])
        let msgs = ContentValidator.validate(c).map(\.message)
        #expect(msgs.contains("duplicate lesson id") && msgs.contains("duplicate activity id"))
    }

    @Test func detectsBadPayload() throws {
        var c = try Fixtures.curriculum()
        c.units[0].lessons[0].activities[0].payload = json(#"{"prompt":"only a prompt"}"#)
        #expect(ContentValidator.validate(c).contains { $0.path.hasSuffix("downs-01-mc") })
    }

    @Test func detectsInvalidEngineInvariant() throws {
        var c = try Fixtures.curriculum()
        var p = try c.units[0].lessons[0].activities[0].payload.decode(MultipleChoicePayload.self)
        p.correctOptionIds = ["zzz"]
        c.units[0].lessons[0].activities[0].payload = try JSONValue.from(p)
        #expect(!ContentValidator.validate(c).isEmpty)
    }

    @Test func detectsManifestCurriculumMismatch() throws {
        var m = try Fixtures.manifest()
        m.foundationalModules.append(.init(id: "missing-unit", title: "x", summary: nil))
        #expect(ContentValidator.validate(manifest: m, curriculum: try Fixtures.curriculum()).contains { $0.path.contains("missing-unit") })
    }

    @Test func talkTracksValidated() throws {
        var c = try Fixtures.curriculum()
        c.talkTracks?[0].unlockedByUnitId = "ghost"
        #expect(ContentValidator.validate(c).contains { $0.message.contains("ghost") })
    }
}

@Suite("PersonalizationResolver")
struct PersonalizationTests {
    @Test func substitutesTokens() {
        let r = PersonalizationResolver(values: ["team": "Philadelphia Eagles"])
        #expect(r.resolve("Ask about the {{team}} offense.") == "Ask about the Philadelphia Eagles offense.")
        #expect(r.resolve("{{ team }} and {{team}}") == "Philadelphia Eagles and Philadelphia Eagles")
    }
    @Test func missingValuesFallBackToGenericCopy() {
        let r = PersonalizationResolver(values: [:], fallbacks: ["league": "the league"])
        #expect(r.resolve("Follow {{team}} in {{league}}.") == "Follow their team in the league.")
    }
    @Test func leavesUnterminatedTokensAlone() {
        #expect(PersonalizationResolver(values: [:]).resolve("broken {{team") == "broken {{team")
        #expect(PersonalizationResolver(values: [:]).resolve("no tokens") == "no tokens")
    }
    @Test func buildsFromInterest() {
        let i = PersonInterest(courseId: "c", personalization: ["driver": "Lando"])
        #expect(PersonalizationResolver(interest: i).resolve("{{driver}}") == "Lando")
    }
}

@Suite("Progress repositories")
struct RepositoryTests {
    @Test func inMemoryDefaultsAndRoundTrip() async throws {
        let r = InMemoryProgressRepository()
        #expect(try await r.learnerState().hearts == 5)
        #expect(try await r.progress(personId: "p", courseId: "c").lessonResults.isEmpty)
        var s = try await r.learnerState(); s.totalXP = 42
        try await r.save(s)
        #expect(try await r.learnerState().totalXP == 42)
        var p = try await r.progress(personId: "p", courseId: "c")
        p.lessonResults["l1"] = .init(completedAt: Date(timeIntervalSince1970: 0), correctCount: 1, totalCount: 1, xpEarned: 10)
        try await r.save(p)
        #expect(try await r.progress(personId: "p", courseId: "c").isLessonComplete("l1"))
        #expect(try await r.progress(personId: "other", courseId: "c").isLessonComplete("l1") == false)
    }

    @Test func fileRepositoryPersistsAcrossInstances() async throws {
        let dir = Fixtures.tempDir()
        defer { try? FileManager.default.removeItem(at: dir) }
        let a = FileProgressRepository(directory: dir)
        var s = LearnerState()
        s.addXP(120, now: Fixtures.date(2026, 9, 30), timeZone: Fixtures.utc)
        s.loseHearts(2, now: Fixtures.date(2026, 9, 30))
        try await a.save(s)
        var m = CourseMastery(courseId: "american-football")
        m.apply([.init(conceptId: "downs", delta: 0.2, correct: true)], activityId: "x", now: Fixtures.date(2026, 9, 30), policy: ReviewPolicy())
        try await a.save(m)
        var p = CourseProgress(personId: "sarah", courseId: "american-football")
        p.lastDailyBiteDay = DayKey(year: 2026, month: 9, day: 30)
        try await a.save(p)

        let b = FileProgressRepository(directory: dir)
        #expect(try await b.learnerState() == s)
        #expect(try await b.mastery(courseId: "american-football") == m)
        #expect(try await b.progress(personId: "sarah", courseId: "american-football") == p)
    }

    @Test func fileRepositoryWritesExpectedFiles() async throws {
        let dir = Fixtures.tempDir()
        defer { try? FileManager.default.removeItem(at: dir) }
        let r = FileProgressRepository(directory: dir.appendingPathComponent("nested/store"))
        try await r.save(LearnerState())
        try await r.save(CourseMastery(courseId: "c1"))
        try await r.save(CourseProgress(personId: "p1", courseId: "c1"))
        let names = try FileManager.default.contentsOfDirectory(atPath: dir.appendingPathComponent("nested/store").path).sorted()
        #expect(names == ["learner.json", "mastery-c1.json", "progress-p1-c1.json"])
    }

    @Test func fileRepositoryDefaultsWhenEmptyAndSanitizesNames() async throws {
        let dir = Fixtures.tempDir()
        defer { try? FileManager.default.removeItem(at: dir) }
        let r = FileProgressRepository(directory: dir)
        #expect(try await r.learnerState() == LearnerState())
        #expect(FileProgressRepository.safe("../etc/passwd") == "___etc_passwd")
        try await r.save(CourseProgress(personId: "../evil", courseId: "c"))
        #expect(try FileManager.default.contentsOfDirectory(atPath: dir.path).allSatisfy { !$0.contains("/") })
    }

    @Test func personRepositoriesCrud() async throws {
        let dir = Fixtures.tempDir()
        defer { try? FileManager.default.removeItem(at: dir) }
        let repos: [any PersonRepository] = [InMemoryPersonRepository(), FilePersonRepository(directory: dir)]
        for repo in repos {
            try await repo.save(Fixtures.sarah)
            var jordan = Person(id: "jordan", displayName: "Jordan", relationship: .friend)
            try await repo.save(jordan)
            jordan.displayName = "Jordan B"
            try await repo.save(jordan)
            let all = try await repo.people()
            #expect(all.map(\.displayName) == ["Sarah", "Jordan B"])
            try await repo.delete(personId: "sarah")
            #expect(try await repo.people().map(\.id) == ["jordan"])
        }
        // File store survives a new instance and keeps interests.
        let again = FilePersonRepository(directory: dir)
        #expect(try await again.people().first?.displayName == "Jordan B")
    }

    @Test func personCodableRoundTripKeepsInterests() throws {
        let data = try JSONEncoder().encode(Fixtures.sarah)
        let back = try JSONDecoder().decode(Person.self, from: data)
        #expect(back == Fixtures.sarah)
        #expect(back.interest(for: "american-football")?.personalization["team"] == "Philadelphia Eagles")
        #expect(back.interest(for: "hiking") == nil)
        #expect(PersonInterest(courseId: "a", isMainInterest: true).weight == 2 && PersonInterest(courseId: "a").weight == 1)
    }
}

@Suite("Providers")
struct ProviderTests {
    @Test func liveDataPersonalizesByTeam() async throws {
        let p = MockLiveDataProvider()
        let mine = try await p.scores(courseId: "american-football", personalization: ["team": "Philadelphia Eagles"])
        #expect(mine.map(\.id) == ["r1"])
        let all = try await p.scores(courseId: "american-football", personalization: [:])
        #expect(all.count == 2)
        let unknownTeam = try await p.scores(courseId: "american-football", personalization: ["team": "Nobody FC"])
        #expect(unknownTeam.count == 2)   // falls back to everything rather than empty
    }

    @Test func scheduleIsSortedAndStandingsReturned() async throws {
        let p = MockLiveDataProvider()
        let s = try await p.schedule(courseId: "c", personalization: [:])
        #expect(s.map(\.id) == ["u1", "u2"] && s[0].status == .scheduled)
        #expect(try await p.standings(courseId: "c", personalization: [:])[0].rows[0].name == "Philadelphia Eagles")
    }

    @Test func liveContextAggregates() async throws {
        let now = Date(timeIntervalSince1970: 1_790_100_000)
        let ctx = try await MockLiveDataProvider().liveContext(courseId: "american-football", personalization: ["team": "Philadelphia Eagles"], now: now)
        #expect(ctx.courseId == "american-football" && ctx.generatedAt == now)
        #expect(ctx.recentResults.count == 1 && ctx.upcoming.count == 1 && ctx.standings.count == 1)
        #expect(try JSONDecoder().decode(LiveContext.self, from: JSONEncoder().encode(ctx)) == ctx)
    }

    @Test func liveDataFailurePropagates() async {
        struct Boom: Error {}
        let p = MockLiveDataProvider(failure: Boom())
        await #expect(throws: Boom.self) { try await p.scores(courseId: "c", personalization: [:]) }
    }

    @Test func fixtureInvolvesIsCaseInsensitive() {
        #expect(MockLiveDataProvider.sampleResults[0].involves("philadelphia eagles"))
        #expect(!MockLiveDataProvider.sampleResults[0].involves("Chiefs"))
    }

    @Test func editorialDailyBiteIsStablePerDayAndRotates() async throws {
        let p = MockEditorialProvider()
        let d1 = DayKey(year: 2026, month: 9, day: 30)
        let a = try await p.dailyBite(courseId: "american-football", personalization: [:], on: d1)
        let b = try await p.dailyBite(courseId: "american-football", personalization: [:], on: d1)
        let next = try await p.dailyBite(courseId: "american-football", personalization: [:], on: d1.adding(days: 1))
        #expect(a == b && a != next)
        #expect(try await p.dailyBite(courseId: "hiking", personalization: [:], on: d1) == nil)
    }

    @Test func dailyBiteShapeAndCodable() throws {
        let bite = MockEditorialProvider.samples[0]
        #expect(!bite.headline.isEmpty && !bite.whyItMatters.isEmpty && !bite.sayThisToday.isEmpty && !bite.publisher.isEmpty)
        #expect(bite.sourceURL.scheme == "https")
        #expect(try JSONDecoder().decode(DailyBite.self, from: JSONEncoder().encode(bite)) == bite)
    }

    @Test func editorialTopicsFilterByCourse() async throws {
        #expect(try await MockEditorialProvider().topics(courseId: "american-football", personalization: [:]).count == 2)
        #expect(try await MockEditorialProvider().topics(courseId: "x", personalization: [:]).isEmpty)
    }
}
