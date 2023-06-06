//
//  ApiManager.swift
//  GEEKS-HomeWork-6-M4
//
//  Created by MacBook Pro on 6/6/23.
//

import Foundation

enum RequestType {
    case get
    case post(id: Int, title: String)
}

enum DataModelType {
    case model(ProductModel)
    case value(Int)
}


struct ApiManager {
    static var shared = ApiManager()
    
    func dataManager(requestType: RequestType, completion: @escaping (Result<DataModelType,Error>) -> Void) {
        switch requestType {
        case .get:
            guard let url = URL(string:"https://dummyjson.com/products")  else {return}
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let safeData = data else {return}
                do {
                    let model = try JSONDecoder().decode(ProductModel.self, from: safeData)
                    completion(.success(.model(model)))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        case .post(let id,let title):
            guard let url = URL(string:"https://dummyjson.com/products/add")  else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let products = ProductModel(products: [.init(id: id, title: title)], total: 1,skip: 1,limit: 1)
            request.httpBody = try? JSONEncoder().encode(products)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {return}
                
                do {
                    completion(.success(.value(response.statusCode)))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
