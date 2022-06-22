import Foundation
import OneWay
import ReactorKit
import ComposableArchitecture
import ReSwift

// MARK: - OneWay

final class TestWay: Way<TestWay.Action, TestWay.State> {
    enum Action {
        case increment
    }

    struct State {
        var number: Int
    }

    override func reduce(state: inout State, action: Action) -> SideWay<Action, Never> {
        switch action {
        case .increment:
            state.number += 1
            return .none
        }
    }
}

// MARK: - ReactorKit

final class TestReactor: Reactor {

    enum Action {
        case increment
    }

    enum Mutation {
        case increment
    }

    struct State {
        var number: Int
    }

    var initialState: State

    init(initialState: State) {
        self.initialState = initialState
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increment:
            return .just(.increment)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increment:
            state.number += 1
            return state
        }
    }
}

// MARK: - ComposableArchitecture

struct TCAState: Equatable {
    var number: Int = 0
}

enum TCAAction: Equatable {
    case increment
}

struct TCAEnvironment {}

let tcaReducer = ComposableArchitecture.Reducer<
    TCAState, TCAAction, TCAEnvironment
> { state, action, environment in
    switch action {
    case .increment:
        state.number += 1
        return .none
    }
}

// MARK: - ReSwift

struct ReSwiftState {
    var number: Int = 0
}

struct ReSwiftIncrementAction: ReSwift.Action {}

func reSwiftReducer(action: ReSwift.Action, state: ReSwiftState?) -> ReSwiftState {
    var state = state ?? ReSwiftState()
    switch action {
    case _ as ReSwiftIncrementAction:
        state.number += 1
    default:
        break
    }
    return state
}

// MARK: - Mobius

struct MobiusModel: Equatable {
    var number: Int = 0
}

enum MobiusEvent {
    case increment
}

func mobiusUpdate(model: MobiusModel, event: MobiusEvent) -> MobiusModel {
    var model = model
    switch event {
    case .increment:
        model.number += 1
        return model
    }
}
