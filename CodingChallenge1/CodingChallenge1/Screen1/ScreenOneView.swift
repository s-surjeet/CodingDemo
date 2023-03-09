//
//  ScreenOneView.swift
//  CodingChallenge1
//
//  Created by Surjeet on 09/03/23.
//

import SwiftUI
import AlertToast

struct ScreenOneView: View {
    
    @ObservedObject var viewModel = ScreenOneViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Person List").font(.title).fontWeight(.semibold)//.padding(.top, 10)
                
                List(viewModel.persons) { person in
                    NavigationLink(destination: ScreenSecondView(id: person.id)) {
                        
                        HStack(alignment: .center, spacing: 20.0, content: {
                            
                            Text("\(person.firstName ?? "") \(person.lastName ?? "")")
                                .font(.title2)
                            Image(systemName: person.getPriority().imageIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(person.getPriority().imgColor)
                        })
                    }
                }
                Spacer()
            }
            .refreshable {
                self.viewModel.fetchPersonList(isRefresh: true)
            }
            .toast(isPresenting: $viewModel.showToast, duration: 3, tapToDismiss: true, alert: {
                AlertToast(type: .regular, title: self.viewModel.toastMessage)
            })
            //.navigationTitle("My App")
        }
    }
}

struct ScreenOneView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenOneView()
    }
}
