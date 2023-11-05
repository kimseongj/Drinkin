//
//  LoginDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation

final class LoginDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let ingredientInformationEndpoint = IngredientDetailEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeLoginRepository() -> LoginRepository {
        return DefaultLoginRepository(tokenManager: dependencies.tokenManager,
                                                 provider: dependencies.provider,
                                                 endpoint: ingredientInformationEndpoint
                                                 )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return DefaultLoginViewModel(loginRepository: makeLoginRepository())
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
}
