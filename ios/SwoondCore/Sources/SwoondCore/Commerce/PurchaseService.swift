import Foundation

public enum SubscriptionPeriod: String, Codable, Sendable, Hashable, CaseIterable { case yearly, monthly }

/// A paywall plan row. Prices here are placeholders (design README) until StoreKit products are configured.
public struct SubscriptionPlan: Sendable, Hashable, Identifiable {
    public var period: SubscriptionPeriod
    public var title: String
    public var subtitle: String
    public var priceText: String
    /// e.g. "Save 40%".
    public var badge: String?
    public var id: String { period.rawValue }
    public init(period: SubscriptionPeriod, title: String, subtitle: String, priceText: String, badge: String? = nil) {
        self.period = period; self.title = title; self.subtitle = subtitle; self.priceText = priceText; self.badge = badge
    }

    public static let placeholders: [SubscriptionPlan] = [
        SubscriptionPlan(period: .yearly, title: "Yearly", subtitle: "$4.99/mo, billed $59.99", priceText: "$59.99", badge: "Save 40%"),
        SubscriptionPlan(period: .monthly, title: "Monthly", subtitle: "Billed monthly", priceText: "$7.99"),
    ]
}

public enum PurchaseOutcome: Sendable, Equatable {
    case purchased
    case cancelled
    case pending
    case failed(String)
}

/// Seam for StoreKit 2. The app supplies an implementation; Core and tests use `MockPurchaseService`.
public protocol PurchaseService: Sendable {
    func plans() async -> [SubscriptionPlan]
    func purchase(_ period: SubscriptionPeriod) async -> PurchaseOutcome
    func restore() async -> PurchaseOutcome
    func hasEntitlement() async -> Bool
}

public actor MockPurchaseService: PurchaseService {
    private var entitled: Bool
    private var nextOutcome: PurchaseOutcome
    public init(entitled: Bool = false, nextOutcome: PurchaseOutcome = .purchased) { self.entitled = entitled; self.nextOutcome = nextOutcome }

    public func setNextOutcome(_ outcome: PurchaseOutcome) { nextOutcome = outcome }
    public func plans() async -> [SubscriptionPlan] { SubscriptionPlan.placeholders }
    public func purchase(_ period: SubscriptionPeriod) async -> PurchaseOutcome {
        if nextOutcome == .purchased { entitled = true }
        return nextOutcome
    }
    public func restore() async -> PurchaseOutcome { entitled ? .purchased : .failed("Nothing to restore yet.") }
    public func hasEntitlement() async -> Bool { entitled }
}
