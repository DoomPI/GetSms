//
//  BalanceReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

protocol BalanceReducerProtocol: Reducer where State == BalanceState, Intent == BalanceIntent {
}

class BalanceReducer {
    
    // MARK: - Internal vars
    private let formatter: BalanceFormatter
    
    // MARK: - Init
    init(
        formatter: BalanceFormatter
    ) {
        self.formatter = formatter
    }
}

extension BalanceReducer: BalanceReducerProtocol {

    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .Load:
            return .Loading
            
        case .PresentBalance(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentError:
            return .Error
            
        default:
            return currentState

        }
    }
}
