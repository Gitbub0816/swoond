import Foundation

public enum ChallengeStatus: String, Codable, Sendable, Hashable { case pending, accepted, declined, won, lost, tied }

/// A friend challenge (design 3e): same questions, head-to-head.
public struct FriendChallenge: Codable, Sendable, Hashable, Identifiable {
    public var id: String
    public var fromName: String
    public var fromLevel: Int
    public var courseId: CourseID
    public var questionCount: Int
    public var fromCorrect: Int
    public var fromSeconds: Int
    public var prizeXP: Int
    public var status: ChallengeStatus

    public init(id: String, fromName: String, fromLevel: Int, courseId: CourseID, questionCount: Int, fromCorrect: Int, fromSeconds: Int,
                prizeXP: Int = XPValues.challengeWin, status: ChallengeStatus = .pending) {
        self.id = id; self.fromName = fromName; self.fromLevel = fromLevel; self.courseId = courseId; self.questionCount = questionCount
        self.fromCorrect = fromCorrect; self.fromSeconds = fromSeconds; self.prizeXP = prizeXP; self.status = status
    }

    public var interestName: String { InterestCatalog.displayName(for: courseId) }
    /// "4 / 5 in 38s".
    public var scoreLine: String { "\(fromCorrect) / \(questionCount) in \(fromSeconds)s" }
    /// "5 rallies, same questions" for pickleball; generic "questions" otherwise.
    public var formatLine: String { courseId == "pickleball" ? "\(questionCount) rallies, same questions" : "\(questionCount) questions, same for both" }

    /// Higher score wins; the faster time breaks a tie; equal both = tied.
    public func resolve(yourCorrect: Int, yourSeconds: Int) -> ChallengeStatus {
        if yourCorrect != fromCorrect { return yourCorrect > fromCorrect ? .won : .lost }
        if yourSeconds != fromSeconds { return yourSeconds < fromSeconds ? .won : .lost }
        return .tied
    }

    public static let sample = FriendChallenge(id: "challenge-1", fromName: "Jordan", fromLevel: 9, courseId: "pickleball", questionCount: 5, fromCorrect: 4, fromSeconds: 38)
}

/// Seam for a future social backend. Phase 1 uses a canned challenge.
public protocol ChallengeProvider: Sendable {
    func pendingChallenge() async throws -> FriendChallenge?
}

public struct MockChallengeProvider: ChallengeProvider {
    public var challenge: FriendChallenge?
    public init(challenge: FriendChallenge? = .sample) { self.challenge = challenge }
    public func pendingChallenge() async throws -> FriendChallenge? { challenge }
}
