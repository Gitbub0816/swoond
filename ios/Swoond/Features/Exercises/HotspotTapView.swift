import SwiftUI
import SwoondCore

/// hotspot-tap: tap a region on a static or procedural diagram. The correct region is outlined gold, a wrong tap
/// rose. Hotspots are also exposed as an accessibility list ("Strong safety, button").
struct HotspotTapView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: HotspotTapEngine
    @State private var tap: CGPoint?
    @State private var tappedHotspot: String?
    @State private var evaluation: ExerciseEvaluation?

    init(engine: HotspotTapEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
    }

    private var payload: HotspotTapPayload { engine.payload }
    private var aspect: Double { max(0.3, payload.diagram.aspectRatio ?? 1.2) }

    var body: some View {
        ExerciseScaffold(prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator) {
            diagram
        }
    }

    private var diagram: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                if let asset = payload.diagram.asset {
                    AssetImage(asset: asset, alt: payload.diagram.alt).clipShape(RoundedRectangle(cornerRadius: SWRadius.cardLarge, style: .continuous))
                } else {
                    DiagramBackground(style: DiagramBackground.style(kind: nil, diagramId: payload.diagram.diagramId))
                }
                if evaluation != nil {
                    ForEach(payload.hotspots) { hotspot in
                        let isCorrect = payload.correctHotspotIds.contains(hotspot.id)
                        let isWrongTap = hotspot.id == tappedHotspot && !isCorrect
                        if isCorrect || isWrongTap {
                            outline(hotspot.shape, size: size)
                                .stroke(isCorrect ? Color.sw.reward : Color.sw.accent, style: StrokeStyle(lineWidth: 3, dash: isCorrect ? [] : [6, 4]))
                        }
                    }
                }
                if let tap {
                    Circle().fill(Color.sw.accent).frame(width: 14, height: 14)
                        .overlay(Circle().strokeBorder(Color.sw.ink, lineWidth: 2))
                        .position(x: tap.x * size.width, y: tap.y * size.height)
                }
            }
            .contentShape(Rectangle())
            .gesture(SpatialTapGesture().onEnded { value in
                guard size.width > 0, size.height > 0 else { return }
                answer(x: Double(value.location.x / size.width), y: Double(value.location.y / size.height))
            })
        }
        .aspectRatio(aspect, contentMode: .fit)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(payload.diagram.alt)
        .accessibilityChildren {
            ForEach(payload.hotspots) { hotspot in
                Button(hotspot.label) { answer(hotspotId: hotspot.id) }
            }
        }
    }

    /// Circle radii are fractions of the diagram width (Core's `HotspotTapEngine.contains`).
    private func outline(_ shape: HotspotShape, size: CGSize) -> Path {
        switch shape {
        case .circle(let cx, let cy, let r):
            let radius = r * size.width
            return Path(ellipseIn: CGRect(x: cx * size.width - radius, y: cy * size.height - radius, width: radius * 2, height: radius * 2))
        case .rect(let x, let y, let w, let h):
            return Path(roundedRect: CGRect(x: x * size.width, y: y * size.height, width: w * size.width, height: h * size.height), cornerRadius: 6)
        }
    }

    private func answer(x: Double, y: Double) {
        guard evaluation == nil, let result = try? engine.submit(x: x, y: y) else { return }
        tap = CGPoint(x: x, y: y)
        tappedHotspot = engine.hotspot(atX: x, y: y)?.id
        evaluation = result
        coordinator.submit(.point(x: x, y: y))
    }

    private func answer(hotspotId: String) {
        guard evaluation == nil, let result = try? engine.submit(hotspotId: hotspotId) else { return }
        tappedHotspot = hotspotId
        evaluation = result
        coordinator.submit(.choices([hotspotId]))
    }
}

#Preview("Hotspot tap") {
    ExercisePreview { c in HotspotTapView(engine: PreviewData.hotspotTap(), coordinator: c) }
}
