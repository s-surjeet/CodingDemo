//
//  DataManager.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import Foundation

// MARK: - DataManagerProtocol
protocol DataManagerProtocol {
    func fetchPersonData(id: String, isLoadNewData: Bool, completion: @escaping CompletionHandler<Person>)
    func fetchPersonList(isLoadNewData: Bool, completion: @escaping CompletionHandler<[Person]>)
}


// MARK: - DataManager
class DataManager {
    
    //we will implement Singleton here, we know that we need only one instance.
    static let shared: DataManagerProtocol = DataManager()
    //Store the API Data
    private var persons: [Person]?
    
    // Inject network layer
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}


// MARK: - Implement DataManagerProtocol
extension DataManager: DataManagerProtocol {
    
    func fetchPersonData(id: String, isLoadNewData: Bool = false, completion: @escaping CompletionHandler<Person>) {
        //If already we have personList data
        if let persons = self.persons, !persons.isEmpty, !isLoadNewData,
           let person = persons.first(where: {$0.id == id}) {
            completion(.success(person))
            return
        }
        //Fetch new data from server
        self.fetchPersonDataFromServer(id: id, completion: completion)
    }
    
    func fetchPersonList(isLoadNewData: Bool = false, completion: @escaping CompletionHandler<[Person]>) {
        //If already we have personList data
        if let persons = self.persons, !persons.isEmpty, !isLoadNewData {
            completion(.success(persons))
            return
        }
        //Fetch new data from server
        self.fetchPersonListFromServer(completion: completion)
    }
}

// MARK: - Get Data from Server
extension DataManager {
    
    private func fetchPersonDataFromServer(id: String, completion: @escaping CompletionHandler<Person>) {
        //Fetch new data from server
        self.networkManager.fetchPersonData(id: id) { (result) in
            switch result {
            case .success(let personData):
                completion(.success(personData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchPersonListFromServer(completion: @escaping CompletionHandler<[Person]>) {
        //Fetch new data from server
        self.networkManager.fetchPersonList(completion: { [weak self] responseResult in
            switch responseResult {
            case .success(let personList):
                self?.persons = personList
                completion(.success(personList))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
