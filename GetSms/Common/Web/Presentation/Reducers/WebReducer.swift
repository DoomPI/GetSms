//
//  WebReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

protocol WebReducerProtocol: Reducer where Intent == WebIntent, State == WebState {
}

class WebReducer {
    
}

extension WebReducer: WebReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        
        switch intent {
            
        case .Reload:
            return .PresentReload
            
        case .Forward:
            return .PresentForward
            
        case .Backward:
            return .PresentBackward
            
        }
    }
}
