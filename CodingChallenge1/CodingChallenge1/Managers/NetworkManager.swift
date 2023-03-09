//
//  NetworkManager.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.

import Foundation

typealias CompletionHandler<T> = (Result<T, Error>) -> Void

struct Response: Decodable {
    let status: String
    let data: [Person]
}

enum NetworkError: Error {
    case failed
}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func fetchPersonData(id: String, completion: @escaping CompletionHandler<Person>)
    func fetchPersonList(completion: @escaping CompletionHandler<[Person]>)
}

// MARK: - NetworkManager
class NetworkManager {
    
    //we will implement Singleton here, we know that we need only one instance.
    static let shared: NetworkManagerProtocol = NetworkManager()
}

// MARK: - Implement NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
    //Temporary we fetch person list and filter by id and give it to the response
    func fetchPersonData(id: String, completion: @escaping CompletionHandler<Person>) {
        self.fetchPersonList { (result) in
            switch result {
            case .success(let personList):
                
                guard let person = personList.first(where: {$0.id == id}) else {
                    let error = NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey: "Data associated with this ID was not found."])
                    completion(.failure(error))
                    return
                }
                completion(.success(person))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPersonList(completion: @escaping CompletionHandler<[Person]>) {
        // Simulate a network request by delaying the response for 2 second
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            
            // Simulate network response with dummy data list
            guard let path = Bundle.main.path(forResource: "person-list-api-json-data", ofType: "json") else {
                let error = NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey: "Something went wrong, Unable to get data"])
                completion(.failure(error))
                return
            }
            let url = URL(fileURLWithPath: path)
            
            //Now fetch data from URL
            self.fetchAndParseJsonData(url: url, Response.self) { (result) in
                switch result {
                case .success(let response):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Parse JSON Data
extension NetworkManager {
    
    private func fetchAndParseJsonData<T: Decodable>(url: URL, _ type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(type, from: jsonData)
            completion(.success(response))
        } catch (let error) {
            completion(.failure(error))
        }
    }
}
