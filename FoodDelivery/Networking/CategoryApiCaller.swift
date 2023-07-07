//
//  ApiCaller.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

final class CategoryApiCaller {
    static let share = CategoryApiCaller()
    
    struct Constant {
        static let categoryAPIURL = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54")
    }
    
    private init() {}
    
    public func getRequest(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = Constant.categoryAPIURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewCategory.self, from: data)
                    print(result.сategories.count)
                    completion(.success(result.сategories))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
