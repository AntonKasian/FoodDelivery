//
//  Model.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import Foundation

// MARK: - NewFile
struct NewCategory: Codable {
    let сategories: [Category]
}

// MARK: - Сategory
struct Category: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}
