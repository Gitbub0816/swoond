import SwiftUI
import SwoondCore

/// Picks the SwiftUI view for the current native exercise. One view per catalog type, driven by the engines in
/// `SwoondCore/Exercises` (built by `ExerciseSessionFactory` inside `LearningSession`).
struct NativeExerciseView: View {
    var session: any ExerciseSession
    var coordinator: ExerciseCoordinator

    var body: some View {
        switch session {
        case let e as MultipleChoiceEngine: MultipleChoiceView(engine: e, coordinator: coordinator)
        case let e as BinaryCallEngine: BinaryCallView(engine: e, coordinator: coordinator)
        case let e as TermMatchEngine: TermMatchView(engine: e, coordinator: coordinator)
        case let e as SequenceOrderEngine: SequenceOrderView(engine: e, coordinator: coordinator)
        case let e as VisualIDEngine: VisualIDView(engine: e, coordinator: coordinator)
        case let e as DecisionScenarioEngine: DecisionScenarioView(engine: e, coordinator: coordinator)
        case let e as TalkTrackEngine: TalkTrackView(engine: e, coordinator: coordinator)
        case let e as TimingTapEngine: TimingTapView(engine: e, coordinator: coordinator)
        case let e as SayThisEngine: SayThisView(engine: e, coordinator: coordinator)
        case let e as FillTheGapEngine: FillTheGapView(engine: e, coordinator: coordinator)
        case let e as ListeningIDEngine: ListeningIDView(engine: e, coordinator: coordinator)
        case let e as EstimateSliderEngine: EstimateSliderView(engine: e, coordinator: coordinator)
        case let e as HotspotTapEngine: HotspotTapView(engine: e, coordinator: coordinator)
        default: UnsupportedExerciseView(typeName: session.activityType.rawValue, coordinator: coordinator)
        }
    }
}
