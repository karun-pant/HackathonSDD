//
//  LocationPickerView.swift
//  hackathon-sdui
//
//  Created by Anurag Agnihotri on 12/05/23.
//

import SwiftUI

typealias StringClosure = (String?) -> ()
typealias EmptyClosure = () -> ()

struct LocationPickerView: View {
    let locations: [String] = ["Albuquerque, NM",
                               "Anaheim CA",
                               "Atlanta, GA",
                               "Atlantic City, NJ",
                               "Austin, TX",
                               "Baltimore, MD",
                               "Boston, MA",
                               "Charleston, SC",
                               "Charlotte, NC",
                               "Chicago, IL",
                               "Cincinnati OH",
                               "Cleveland, OH",
                               "Columbus, OH",
                               "Dallas, TX",
                               "Denver, CO",
                               "Flagstaff, AZ",
                               "Fort Lauderdale, FL",
                               "Houston, TX"]
    
    @State var selectedLocation: String = ""
    let onDismiss: EmptyClosure?
    let onDone: StringClosure?
    
    var body: some View {
        NavigationStack {
            List(locations, id: \.self) { location in
                Text(location)
                    .foregroundColor(selectedLocation == location ? .blue : .black)
                    .font(.system(size: 14, weight: .medium))
                    .onTapGesture {
                        selectedLocation = location
                    }
            }
            .listStyle(.plain)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(ColorHelper.swiftUIColor(fromHex: "#007AFF") ?? Color.blue, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("Select Location")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Done") {
                        onDone?(selectedLocation)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))
                }
            }
        }
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView(onDismiss: nil, onDone: nil)
    }
}
