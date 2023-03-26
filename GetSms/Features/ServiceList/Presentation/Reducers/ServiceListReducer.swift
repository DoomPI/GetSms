//
//  ServiceListReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

protocol ServiceListReducerProtocol: Reducer where State == ServiceListState, Intent == ServiceListIntent {
}

class ServiceListReducer: ServiceListReducerProtocol {
    
    typealias State = ServiceListState
    typealias Intent = ServiceListIntent
    
    
    // MARK: - Internal vars
    private let formatter: ServiceListFormatter
    private let errorFormatter: ServiceListErrorFormatter
    
    init(
        formatter: ServiceListFormatter,
        errorFormatter: ServiceListErrorFormatter
    ) {
        self.formatter = formatter
        self.errorFormatter = errorFormatter
    }
    
    func reduce(intent: Intent) -> State {
        switch intent {
            
        case .LoadList:
            return .Loading
            
        case .PresentList(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentError:
            return .Error(vo: errorFormatter.format())
        }
    }
}
