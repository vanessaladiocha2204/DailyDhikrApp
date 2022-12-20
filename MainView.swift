//
//  File.swift
//  SmartDhikr
//
//  Created by Vanessa Ladiocha on 15/04/22.
//

import Foundation
import SwiftUI

struct MainView : View {
    private enum Field: Int, CaseIterable {
            case dhikrName, target
        }
    @State var dhikrName : String = ""
    @State var target : String = ""
    @State var isSubmitted : Bool = false
    @State var isFormSet : Bool = false
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Main Page Design")
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Dhikr")
                        .bold()
                    
                    TextField("Fill in dhikr (e.g. Subhanallah) ", text: $dhikrName)
                        .keyboardType(.default)
                        .focused($focusedField, equals: .dhikrName)
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.brown, lineWidth: 2)
                            )
                    }
                    .padding(.top, 300)
                    
                    VStack(alignment: .leading) {
                        Text("Target")
                            .bold()
                    
                    
                        TextField("Fill in target in numbers", text: $target)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .target)
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        focusedField = nil
                                    }
                                }
                            }
                            .submitLabel(.done)
                            .padding()
                            .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.brown, lineWidth: 2)
                                )
                    }
                    .padding(.bottom, 30)
                   
                    
                    VStack(alignment: .center){
                        NavigationLink(destination: Counter(dhikrName: dhikrName, target: target), isActive: $isFormSet, label: {
                            Button(action: {
                                isFormSet = getFormSet(dhikrName: dhikrName, target: target)
                                isSubmitted = true
                            }, label: {
                                Text("Start")
                                    .bold()
                            })
                        }).onAppear() {
                            isSubmitted = false
                        }
                        
                    }
                    .foregroundColor(.white)
                    .padding()
                    .padding(.leading, 70)
                    .padding(.trailing, 70)
                    .background(.brown)
                    .cornerRadius(12)
                    .padding(.top)
                    
                    
                }
                .padding(50)
                
                if isSubmitted && !isFormSet {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .imageScale(.large)
                            
                    
                        Text("Please fill the form!")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .padding(3)
                            .background(.red)
                            .cornerRadius(5)
                    }
                    .padding(.top, 425)
                    .padding(.trailing, 140)
                   }
            }
        }
        

    }
}

func getFormSet(dhikrName: String, target: String) -> Bool {
    if dhikrName == "" {
        return false
    } else if target == "" {
        return false
    }
    return true
}



