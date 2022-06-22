import XCTest
import OneWay
import ReactorKit
import ComposableArchitecture
import ReSwift
import MobiusCore
import MobiusExtras

final class Benchmark: XCTestCase {

    let iteration: Int = 10_000
    var options: XCTMeasureOptions = {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
        return options
    }()

    func testOneWay() {
        let cpu = XCTCPUMetric()
        measure(metrics: [cpu], options: options) {
            let way = TestWay(initialState: .init(number: 0))
            for _ in 0..<iteration {
                way.send(.increment)
            }
            XCTAssertEqual(way.currentState.number, iteration)
        }
    }

    func testReactorKit() {
        let cpu = XCTCPUMetric()
        measure(metrics: [cpu], options: options) {
            let reactor = TestReactor(initialState: .init(number: 0))
            for _ in 0..<iteration {
                reactor.action.onNext(.increment)
            }
            XCTAssertEqual(reactor.currentState.number, iteration)
        }
    }

    func testTCA() {
        let cpu = XCTCPUMetric()
        measure(metrics: [cpu], options: options) {
            let store = ComposableArchitecture.Store(
                initialState: TCAState(),
                reducer: tcaReducer,
                environment: TCAEnvironment()
            )
            let viewStore = ViewStore(store)
            for _ in 0..<iteration {
                viewStore.send(.increment)
            }
            XCTAssertEqual(viewStore.state.number, iteration)
        }
    }

    func testReSwift() {
        let cpu = XCTCPUMetric()
        measure(metrics: [cpu], options: options) {
            let reSwiftStore = ReSwift.Store<ReSwiftState>(
                reducer: reSwiftReducer,
                state: ReSwiftState()
            )
            for _ in 0..<iteration {
                reSwiftStore.dispatch(ReSwiftIncrementAction())
            }
            XCTAssertEqual(reSwiftStore.state.number, iteration)
        }
    }

    func testMobius() {
        let cpu = XCTCPUMetric()
        measure(metrics: [cpu], options: options) {
            let loop = Mobius.beginnerLoop(update: mobiusUpdate)
                .start(from: MobiusModel())
            for _ in 0..<iteration {
                loop.dispatchEvent(.increment)
            }
            XCTAssertEqual(loop.latestModel.number, iteration)
        }
    }
}
