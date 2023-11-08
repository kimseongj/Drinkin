//
//  SavedCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

struct SavedCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "https://c13025fe-95c2-4dff-b547-2ea025ecc005.mock.pstmn.io"
    
    var path: String = "/previewdescription"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
