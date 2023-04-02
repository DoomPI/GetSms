//
//  CountryListReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

protocol CountryListReducerProtocol: Reducer where State == CountryListState, Intent == CountryListIntent {
}

class CountryListReducer {
    
    // MARK: - Internal vars
    private let formatter: CountryListFormatter
    private let errorFormatter: CountryListErrorFormatter
    
    // MARK: - Init
    init(
        formatter: CountryListFormatter,
        errorFormatter: CountryListErrorFormatter
    ) {
        self.formatter = formatter
        self.errorFormatter = errorFormatter
    }
}

extension CountryListReducer: CountryListReducerProtocol {
    
    func reduce(intent: Intent) -> State {
        switch intent {
            
        case .LoadList:
            return .Loading
            
        case .PresentList(let model):
            return .Loaded(vo: formatter.format(model: model))
            
        case .PresentError(let error):
            return .Error(vo: errorFormatter.format(error: error))
        }
    }
}
