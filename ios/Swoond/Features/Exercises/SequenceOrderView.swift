import SwiftUI
import SwoondCore

/// sequence-order: put the steps in order. Reorder by drag and drop, or with the Move up / Move down buttons and
/// VoiceOver actions (never drag only, CATALOG section 4). After Check, the correct order is revealed with numbered
/// gold badges and each step's `why`.
struct SequenceOrderView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: SequenceOrderEngine
    @State private var items: [SequenceOrderPayload.Item]
    @State private var evaluation: ExerciseEvaluation?

    init(engine: SequenceOrderEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _items = State(initialValue: engine.initialOrder(using: &generator))
        _engine = State(initialValue: engine)
    }

    var body: some View {
        ExerciseScaffold(
            prompt: engine.payload.prompt, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", perform: check)
        ) {
            VStack(spacing: SWSpace.s8) {
                if evaluation == nil {
                    Text("Drag to reorder, or use the arrows.").font(SWText.caption).foregroundStyle(Color.sw.ink3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        row(item, index: index)
                    }
                } else {
                    ForEach(Array(engine.payload.items.enumerated()), id: \.element.id) { index, item in
                        revealedRow(item, number: index + 1)
                    }
                }
            }
        }
    }

    private func row(_ item: SequenceOrderPayload.Item, index: Int) -> some View {
        HStack(spacing: SWSpace.s10) {
            Image(systemName: "line.3.horizontal").foregroundStyle(Color.sw.ink5).accessibilityHidden(true)
            Text(item.text).font(SWFont.ui(15, weight: .medium)).foregroundStyle(Color.sw.ink)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 0) {
                moveButton("chevron.up", label: "Move up", enabled: index > 0) { move(index, by: -1) }
                moveButton("chevron.down", label: "Move down", enabled: index < items.count - 1) { move(index, by: 1) }
            }
        }
        .padding(.horizontal, SWSpace.s14)
        .padding(.vertical, SWSpace.s6)
        .frame(minHeight: 60)
        .swCard(radius: 16, border: Color.sw.strokeStrong)
        .draggable(item.id)
        .dropDestination(for: String.self) { ids, _ in
            guard let id = ids.first else { return false }
            move(id: id, before: item.id)
            return true
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(item.text), position \(index + 1) of \(items.count)")
        .accessibilityAction(named: "Move up") { if index > 0 { move(index, by: -1) } }
        .accessibilityAction(named: "Move down") { if index < items.count - 1 { move(index, by: 1) } }
    }

    private func moveButton(_ symbol: String, label: String, enabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol).font(.system(size: 13, weight: .semibold))
                .frame(width: SWSize.minTarget, height: 28)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .foregroundStyle(enabled ? Color.sw.ink2 : Color.sw.ink5.opacity(0.4))
        .disabled(!enabled)
    }

    private func revealedRow(_ item: SequenceOrderPayload.Item, number: Int) -> some View {
        HStack(alignment: .top, spacing: SWSpace.s12) {
            Text("\(number)")
                .font(SWFont.display(18, italic: true, relativeTo: .headline))
                .foregroundStyle(Color.sw.reward)
                .frame(width: 32, height: 32)
                .overlay(Circle().strokeBorder(Color.sw.reward, lineWidth: 1.5))
            VStack(alignment: .leading, spacing: 2) {
                Text(item.text).font(SWFont.ui(15, weight: .medium)).foregroundStyle(Color.sw.ink)
                if let why = item.why { Text(why).font(SWText.captionSmall).foregroundStyle(Color.sw.ink3) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(SWSpace.s12)
        .swCard(radius: 16, fill: Color.sw.rewardTint, border: Color.sw.reward.opacity(0.4))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Step \(number): \(item.text)")
    }

    // MARK: Actions

    private func move(_ index: Int, by delta: Int) {
        let target = index + delta
        guard evaluation == nil, items.indices.contains(index), items.indices.contains(target) else { return }
        Haptics.shared.selection()
        withAnimation(.swTap) { items.swapAt(index, target) }
    }

    private func move(id: String, before targetId: String) {
        guard evaluation == nil, id != targetId,
              let from = items.firstIndex(where: { $0.id == id }), let to = items.firstIndex(where: { $0.id == targetId }) else { return }
        Haptics.shared.selection()
        withAnimation(.swTap) {
            let moved = items.remove(at: from)
            items.insert(moved, at: to)
        }
    }

    private func check() {
        let order = items.map(\.id)
        guard evaluation == nil, let result = try? engine.submit(order: order) else { return }
        evaluation = result
        coordinator.submit(.order(order))
    }
}

#Preview("Sequence order") {
    ExercisePreview { c in SequenceOrderView(engine: PreviewData.sequenceOrder(), coordinator: c) }
}
