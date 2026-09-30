import SwiftUI
import SwoondCore

/// Procedural diagram surfaces drawn with `Canvas` (no image assets): a pickleball court, a field, or a plain court.
/// Playing surfaces use the `court` token in both modes (DESIGN_SPEC section 3).
enum DiagramStyle: Sendable { case pickleball, field, plain }

struct DiagramBackground: View {
    var style: DiagramStyle
    var cornerRadius: CGFloat = SWRadius.cardLarge

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(Color.sw.court)
            // The renderer closure must not capture `self` (it is not main-actor isolated), only plain values.
            Canvas { [style] context, size in DiagramPainter.draw(style: style, in: &context, size: size) }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(Color.sw.ink.opacity(0.7), lineWidth: 2)
            if style == .pickleball {
                GeometryReader { proxy in
                    Text("KITCHEN")
                        .font(.system(size: 10, weight: .medium)).tracking(1.4)
                        .foregroundStyle(Color.sw.accentSoft)
                        .position(x: proxy.size.width - 34, y: proxy.size.height * 0.56)
                }
            }
        }
        .accessibilityHidden(true)
    }

    /// Choose a surface from a payload's diagram hints.
    static func style(kind: BinaryCallPayload.Scene.Kind?, diagramId: String?) -> DiagramStyle {
        let id = (diagramId ?? "").lowercased()
        if id.contains("pickleball") { return .pickleball }
        if id.contains("field") || id.contains("formation") || id.contains("football") || kind == .fieldDiagram { return .field }
        if kind == .courtDiagram { return .pickleball }
        return .plain
    }
}

/// A marker on a diagram. Shapes differ by role so color is never the only cue: player = ring, ball = solid dot,
/// opponent = plain disc, target = dashed ring.
struct DiagramMarker: View {
    var role: BinaryCallPayload.Scene.Marker.Role

    var body: some View {
        switch role {
        case .player:
            Circle().fill(Color.sw.accent).frame(width: 26, height: 26)
                .overlay(Circle().strokeBorder(Color.sw.ink, lineWidth: 3))
        case .ball:
            Circle().fill(Color.sw.reward).frame(width: 12, height: 12).shadow(color: Color.sw.reward, radius: 5)
        case .opponent:
            Circle().fill(Color.sw.ink3).frame(width: 18, height: 18)
        case .target:
            Circle().strokeBorder(Color.sw.reward, style: StrokeStyle(lineWidth: 2, dash: [4, 3])).frame(width: 24, height: 24)
        }
    }
}

/// Draws diagram surfaces. A plain (non-isolated) type so `Canvas` renderer closures can call it from any thread.
enum DiagramPainter {
    static func draw(style: DiagramStyle, in context: inout GraphicsContext, size: CGSize) {
        let line = Color.sw.ink.opacity(0.7)
        switch style {
        case .pickleball:
            // Non-volley zones (7 ft each side of the net, 22% of the height in the design).
            context.fill(Path(CGRect(x: 0, y: size.height * 0.5, width: size.width, height: size.height * 0.22)),
                         with: .color(Color.sw.accent.opacity(0.16)))
            context.fill(Path(CGRect(x: 0, y: size.height * 0.28, width: size.width, height: size.height * 0.22)),
                         with: .color(Color.sw.accent.opacity(0.08)))
            for y in [0.28, 0.72] {
                var p = Path(); p.move(to: CGPoint(x: 0, y: size.height * y)); p.addLine(to: CGPoint(x: size.width, y: size.height * y))
                context.stroke(p, with: .color(line), lineWidth: 2)
            }
            var centerNear = Path(); centerNear.move(to: CGPoint(x: size.width / 2, y: size.height * 0.72)); centerNear.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            var centerFar = Path(); centerFar.move(to: CGPoint(x: size.width / 2, y: 0)); centerFar.addLine(to: CGPoint(x: size.width / 2, y: size.height * 0.28))
            context.stroke(centerNear, with: .color(line), lineWidth: 2)
            context.stroke(centerFar, with: .color(line), lineWidth: 2)
            var net = Path(); net.move(to: CGPoint(x: 0, y: size.height / 2)); net.addLine(to: CGPoint(x: size.width, y: size.height / 2))
            context.stroke(net, with: .color(Color.sw.ink), lineWidth: 4)
        case .field:
            for i in 1..<10 {
                var p = Path(); let y = size.height * CGFloat(i) / 10
                p.move(to: CGPoint(x: 0, y: y)); p.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(p, with: .color(Color.sw.ink.opacity(i == 5 ? 0.45 : 0.14)), lineWidth: i == 5 ? 2 : 1)
            }
        case .plain:
            var mid = Path(); mid.move(to: CGPoint(x: 0, y: size.height / 2)); mid.addLine(to: CGPoint(x: size.width, y: size.height / 2))
            context.stroke(mid, with: .color(Color.sw.ink.opacity(0.4)), lineWidth: 2)
        }
    }
}
