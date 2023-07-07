//
//  DishesApiCaller.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import Foundation

final class DishesApiCaller {
    
    static let shareDish = DishesApiCaller()
    
    struct Constant {
        static let dishesAPIURL = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b")
    }
    
    private init() {}
    
    public func getRequest(completion: @escaping (Result<[Dish], Error>) -> Void) {
        guard let url = Constant.dishesAPIURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewDishes.self, from: data)
                    print(result.dishes.count)
                    completion(.success(result.dishes))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


