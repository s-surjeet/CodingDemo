//
//  ScreenSecondViewModel.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import Foundation

// MARK: - ScreenSecondViewModel
class ScreenSecondViewModel: ObservableObject {
    // Declare an ID to fetch the person data
    private var personId: String?
    
    @Published var person: Person?
    
    // Inject data layer
    private var dataManager: DataManagerProtocol
    
    //Help to display toast message
    @Published var showToast = false
    var toastMessage = ""
    
    init(personId: String?, dataManager: DataManagerProtocol = DataManager.shared) {
        self.personId = personId
        self.dataManager = dataManager
        self.fetchPersonData()
    }
    
    func fetchPersonData() {
        guard let id = self.personId else {
            return
        }
        dataManager.fetchPersonData(id: id, isLoadNewData: false) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let _person):
                    self?.person = _person
                    
                case .failure(let error):
                    self?.toastMessage = error.localizedDescription
                    self?.showToast.toggle()
                    print(error.localizedDescription)
                }
            }
        }
    }
}
