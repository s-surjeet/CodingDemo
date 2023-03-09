//
//  ScreenOneViewModel.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import Foundation
import AlertToast

// MARK: - ScreenOneViewModel
class ScreenOneViewModel: ObservableObject {
    
    @Published var persons: [Person] = []
    
    //Help to display toast message
    @Published var showToast = false
    var toastMessage = ""
    
    //To check is refresh request is under processing
    private var isRefreshing = false
    
    // Inject data layer
    private var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        self.fetchPersonList()
    }
    
    func fetchPersonList(isRefresh: Bool = false) {
        //To avoid multiple refresh request before api return response
        if isRefresh && isRefreshing {
            return
        }
        self.isRefreshing =  isRefresh
        
        dataManager.fetchPersonList(isLoadNewData: isRefreshing) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.isRefreshing = false
                switch result {
                case .success(let _personList):
                    self?.persons = _personList
                    
                case .failure(let error):
                    self?.toastMessage = error.localizedDescription
                    self?.showToast.toggle()
                    print(error.localizedDescription)
                }
            }
        }
    }
}
