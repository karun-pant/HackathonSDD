//
//  ContentView.swift
//  hackathon-sdui
//
//  Created by Anurag Agnihotri on 11/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert: Bool = false
    @State private var message: String = ""
    let viewModel = RenderableRootViewModel(jsonFile: "flavour2")
    @State var showLocationPicker: Bool = false
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = .now
    
    @State var locationPickerClosure: StringClosure?
    @State var datePickerClosure: StringClosure?
    
    
    @State var openExperiences: Bool = false
    @State var experiencesTitle: String? = nil
    
    var body: some View {
        RenderableContainerRoot(
            viewModel: viewModel,
            onTap: { actionType, modelID, deeplinkIfAny, asynchronousClosure in
                if modelID == "locationPicker" {
                    showLocationPicker = true
                    locationPickerClosure = asynchronousClosure as?
                    StringClosure
                    return nil
                } else if modelID == "datePicker" {
                    showDatePicker = true
                    datePickerClosure = asynchronousClosure as? StringClosure
                    return nil
                } else if modelID.contains("marketing_banner"),
                          let deeplinkIfAny,
                          let screen = deeplinkIfAny.components(separatedBy: "://").last {
                    if screen.contains("experiences") {
                        experiencesTitle = deeplinkIfAny
                            .components(separatedBy: "?")
                            .last?
                            .components(separatedBy: "=")
                            .last
                        openExperiences = true
                    }
                }  else {
                    message = "\(actionType.rawValue.capitalized) Action Done on modelID: \(modelID), with deeplink: \(deeplinkIfAny ?? "NO DEEPLINK")"
                    showAlert = true
                }
                return message
            }, onScroll: { actionType, modelID, deeplinkIfAny, asynchronousClosure in
                message = "\(actionType.rawValue) Action Done on modelID: \(modelID), \(deeplinkIfAny != nil ? "with deeplink: \(deeplinkIfAny ?? "")" : "")"
                showAlert = true
                return message
            })
        .alert("PLNebula View",
               isPresented: $showAlert,
               actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(message)
        })
        .sheet(isPresented: $showLocationPicker) {
            LocationPickerView {
                
            } onDone: { location in
                showLocationPicker = false
                locationPickerClosure?(location)
            }
            
        }
        .sheet(isPresented: $showDatePicker) {
            datePicker
        }
        .sheet(isPresented: $openExperiences) {
            ExperiencesView(jsonFile: "flavour3", title: experiencesTitle ?? "Experiences")
        }
        .onChange(of: selectedDate) { newValue in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, YYYY"
            let date = dateFormatter.string(from: newValue)
            datePickerClosure?(date)
        }
        
    }
    
    @ViewBuilder private var datePicker: some View {
        NavigationStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(ColorHelper.swiftUIColor(fromHex: "#007AFF") ?? Color.blue, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        Text("Select Date")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                    }
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button("Done") {
                            showDatePicker = false
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    }
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
