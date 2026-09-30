import Foundation
import Observation
import SwoondCore

/// Paywall state. StoreKit 2 sits behind `PurchaseService`; with no real product ids configured the plans are the
/// placeholder prices from Core and purchasing reports a friendly "not set up yet" message.
@MainActor
@Observable
final class PaywallViewModel {
    private(set) var plans: [SubscriptionPlan] = SubscriptionPlan.placeholders
    var selected: SubscriptionPeriod = .yearly
    private(set) var isWorking = false
    private(set) var message: String?
    private(set) var didUnlock = false

    func load(model: AppModel) async {
        plans = await model.env.purchases.plans()
        if !plans.contains(where: { $0.period == selected }), let first = plans.first { selected = first.period }
    }

    func purchase(model: AppModel) async {
        isWorking = true
        message = nil
        defer { isWorking = false }
        switch await model.env.purchases.purchase(selected) {
        case .purchased: await unlock(model)
        case .cancelled: break
        case .pending: message = "Your purchase is waiting for approval."
        case .failed(let text): message = text
        }
    }

    func restore(model: AppModel) async {
        isWorking = true
        message = nil
        defer { isWorking = false }
        switch await model.env.purchases.restore() {
        case .purchased: await unlock(model)
        case .cancelled: break
        case .pending: message = "Your purchase is waiting for approval."
        case .failed(let text): message = text
        }
    }

    private func unlock(_ model: AppModel) async {
        await model.setPremium(true)
        didUnlock = true
    }
}
