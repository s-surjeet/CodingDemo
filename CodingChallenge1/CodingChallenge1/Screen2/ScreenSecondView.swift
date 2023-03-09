//
//  ScreenSecondView.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import SwiftUI
import AlertToast

struct ScreenSecondView: View {    
    // Declare a view model to fetch the person data
    @ObservedObject var viewModel: ScreenSecondViewModel
    
    // Initialize the view model and ID
    init(id: String? = nil) {
        self.viewModel = ScreenSecondViewModel(personId: id)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("\(viewModel.person?.firstName ?? "") \(viewModel.person?.lastName ?? "")")
                        .font(.title)
                    
                    Text("Age: \(viewModel.person?.age ?? 0)")
                        .font(.headline)
                    Text("\(viewModel.person?.getPriority().rawValue.capitalized ?? "") Priority")
                        .font(.headline)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 20.0) {
                Text("Email: \(viewModel.person?.email ?? "Not Available")")
                    .font(.headline)
                
                Text("Phone: \(viewModel.person?.phoneNumber ?? "Not Available")")
                    .font(.headline)
            }.padding(.vertical, 10)
            
            Divider()
            Spacer()
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .toast(isPresenting: $viewModel.showToast, duration: 3, tapToDismiss: true, alert: {
            AlertToast(type: .regular, title: self.viewModel.toastMessage)
        })
        /*.onAppear {
            viewModel.fetchPersonData()
        }*/
    }
}

struct ScreenSecondView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSecondView()
    }
}
