//
//  DataProvider.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/8/21.
//

import Foundation

class DataProvider {
    
    public enum DSName: String {
        case first = "first", second = "second", third = "third"
    }
    
    public func localDS(_ name: DSName) -> MainModel {
        
        var string = ""
        switch name {
        case .first:
            string = DataProvider.first
        case .second:
            string = DataProvider.second
        case .third:
            string = DataProvider.third
        }
        let data = string.data(using: String.Encoding.utf8)!
        let model = try! JSONDecoder().decode(MainModel.self, from: data)
        return model
    }
}
