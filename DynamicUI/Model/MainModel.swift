//
//  MainModel.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/8/21.
//

import Foundation

struct MainModel: Decodable {
    
    var items: [Box]
}

// MARK: ---------->>>> BOX
struct Box: Decodable {
    
    enum Layout: String, Decodable {
        case horizontal, vertical
    }
    
    enum Cell: String, Decodable {
        case banner, list, grid
    }
    
    var layout: Box.Layout
    var cell: Box.Cell
    var items: [Box.Item]
    var header: Box.Header?
}

// MARK: ---------->>>> ITEM
extension Box {
    
    struct Item: Decodable {
        
        var id: String
        var image: Box.Item.Image
        var action: Box.Item.Action
        var price: Box.Item.Price?
        var name: String?
    }
}

// MARK: ---------->>>> HEADER
extension Box {
    
    struct Header: Decodable {
        
        var name: String
        var seeAll: Box.Header.SeeAll?
    }
}

// MARK: ---------->>>> SEEALL
extension Box.Header {
    
    struct SeeAll: Decodable {
        
        var action: Box.Item.Action
    }
}

// MARK: ---------->>>> IMAGE
extension Box.Item {
    
    struct Image: Decodable {
        
        var url: String
    }
}

// MARK: ---------->>>> ACTION
extension Box.Item {
    
    struct Action: Decodable {
        
        var url: String
    }
}

// MARK: ---------->>>> PRICE
extension Box.Item {
    
    struct Price: Decodable {
        
        var price: Float
        var currency: String
    }
}
