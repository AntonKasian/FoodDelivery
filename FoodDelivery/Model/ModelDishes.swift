//
//  ModelDishes.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//
import Foundation

struct NewDishes: Codable {
    let dishes: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

//struct Teg: Codable {
//    let name: String
//}

enum Teg: String, Codable {
    case allMenu = "Все меню"
    case withRice = "С рисом"
    case withFish = "С рыбой"
    case salads = "Салаты"
}
