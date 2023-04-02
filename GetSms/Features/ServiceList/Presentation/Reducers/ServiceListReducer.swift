//
//  ServiceListReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

protocol ServiceListReducerProtocol: Reducer where State == ServiceListState, Intent == ServiceListIntent {
}

class ServiceListReducer {
    
    // MARK: - Internal vars
    private let formatter: ServiceListFormatter
    private let errorFormatter: ServiceListErrorFormatter
    
    // MARK: - Init
    init(
        formatter: ServiceListFormatter,
        errorFormatter: ServiceListErrorFormatter
    ) {
        self.formatter = formatter
        self.errorFormatter = errorFormatter
    }
}

extension ServiceListReducer: ServiceListReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .Nothing:
            return currentState
            
        case .LoadList:
            return .Loading
            
        case .SearchService:
            return .Loading
            
        case .PresentList(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentError(let error):
            return .Error(vo: errorFormatter.format(error: error))
        }
    }
}
