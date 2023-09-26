//
//  Parser.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct Parser<T: Decodable> {
    func parse(data: Data) -> T? {
        var decodingResult: T?
        let jsonDecoder = JSONDecoder()
        
        do {
            decodingResult = try jsonDecoder.decode(T.self, from: data)
            return decodingResult
        } catch {
            print("에러 : decode 안됨")
            return nil
        }
    }
}
