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
    
    // MARK: - Init
    init(
        formatter: NumberDataListFormatter
    ) {
        self.formatter = formatter
    }
}

extension NumberListReducer: NumberListReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .LoadList:
            return .Loading
            
        case .PresentList(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentError:
            return .Error
    
        }
    }
}
