//
//  BusketCollectionContent.swift
//  FoodDelivery
//
//  Created by Anton on 12.07.23.
//

import Foundation

class BusketCollectionContent {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageURL: String
    
    init(id: Int, name: String, price: Int, weight: Int, description: String, imageURL: String) {
        self.id = id
        self.name = name
        self.price = price
        self.weight = weight
        self.description = description
        self.imageURL = imageURL
    }
}
