//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine

class LoggedinMainViewModel {
    @Published var briefDescription: [BriefDescription] = []
    
    private let fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase
    
    init(fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase) {
        self.fetchBriefDescriptionUseCase = fetchBriefDescriptionUseCase
    }
    
    
}