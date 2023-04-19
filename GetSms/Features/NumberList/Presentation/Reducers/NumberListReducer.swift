//
//  NumberListReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

protocol NumberListReducerProtocol: Reducer where State == NumberListState, Intent == NumberListIntent {
}

class NumberListReducer {
    
    // MARK: - Internal vars
    private let formatter: NumberDataListFormatter
    private let errorFormatter: NumberDataListErrorFormatter
    
    // MARK: - Init
    init(
        formatter: NumberDataListFormatter,
        errorFormatter: NumberDataListErrorFormatter
    ) {
        self.formatter = formatter
        self.errorFormatter = errorFormatter
    }
}

extension NumberListReducer: NumberListReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .PresentList(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentLoading(let numbersDisplayedCount):
            return .Loading(numbersDisplayedCount: numbersDisplayedCount)
            
        case .PresentError(let error):
            return .Error(vo: errorFormatter.format(error: error))
            
        default:
            return currentState
            
        }
    }
}
