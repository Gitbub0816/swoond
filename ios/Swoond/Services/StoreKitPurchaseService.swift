import Foundation
import StoreKit
import SwoondCore

/// StoreKit 2 behind `PurchaseService`. No real product identifiers exist yet: the ids below are placeholders, so
/// `Product.products(for:)` returns nothing and the paywall shows the placeholder prices from Core with a friendly
/// "not set up yet" result on purchase. Replace the ids (and add a StoreKit configuration file) when products exist.
actor StoreKitPurchaseService: PurchaseService {
    enum ProductID {
        static let yearly = "swoond.plus.yearly.placeholder"
        static let monthly = "swoond.plus.monthly.placeholder"
        static var all: [String] { [yearly, monthly] }
    }

    private var products: [SubscriptionPeriod: Product] = [:]
    private var loaded = false

    func plans() async -> [SubscriptionPlan] {
        await loadProducts()
        guard !products.isEmpty else { return SubscriptionPlan.placeholders }
        return SubscriptionPeriod.allCases.compactMap { period in
            guard let p = products[period] else { return nil }
            switch period {
            case .yearly: return SubscriptionPlan(period: .yearly, title: "Yearly", subtitle: "Billed yearly", priceText: p.displayPrice, badge: "Save 40%")
            case .monthly: return SubscriptionPlan(period: .monthly, title: "Monthly", subtitle: "Billed monthly", priceText: p.displayPrice)
            }
        }
    }

    func purchase(_ period: SubscriptionPeriod) async -> PurchaseOutcome {
        await loadProducts()
        guard let product = products[period] else { return .failed("Swoon\u{2019}d+ isn\u{2019}t set up in this build yet.") }
        do {
            switch try await product.purchase() {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    await transaction.finish()
                    return .purchased
                case .unverified:
                    return .failed("We couldn\u{2019}t verify that purchase.")
                }
            case .userCancelled: return .cancelled
            case .pending: return .pending
            @unknown default: return .failed("Something went wrong.")
            }
        } catch {
            return .failed(error.localizedDescription)
        }
    }

    func restore() async -> PurchaseOutcome {
        do { try await AppStore.sync() } catch { return .failed(error.localizedDescription) }
        return await hasEntitlement() ? .purchased : .failed("Nothing to restore yet.")
    }

    func hasEntitlement() async -> Bool {
        for await result in Transaction.currentEntitlements {
            if case .verified(let t) = result, ProductID.all.contains(t.productID), t.revocationDate == nil { return true }
        }
        return false
    }

    private func loadProducts() async {
        guard !loaded else { return }
        loaded = true
        guard let found = try? await Product.products(for: ProductID.all) else { return }
        for p in found {
            if p.id == ProductID.yearly { products[.yearly] = p }
            if p.id == ProductID.monthly { products[.monthly] = p }
        }
    }
}
