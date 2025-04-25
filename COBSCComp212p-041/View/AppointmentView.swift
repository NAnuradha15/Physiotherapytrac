//
//  AppointmentView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import MapKit

struct AppointmentView: View {
    @StateObject private var vm = AppointmentViewModel()
    @State private var searchResults: [MKLocalSearchCompletion] = []
    @State private var completer = MKLocalSearchCompleter()
    @State private var selectedLocation: String = ""
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack {
                    Text("Appointment Arrange")
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                        .foregroundColor(Color.bgBlack)
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 10)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 15) {
                        
                        HStack(spacing: 15) {
                            TextField("Patient Name", text: $vm.appointmentArrange.patientName)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        HStack(spacing: 15) {
                            DatePicker("Date", selection: $vm.appointmentArrange.date, displayedComponents: .date)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        HStack(spacing: 15) {
                            DatePicker(
                                "Start Time",
                                selection: $vm.appointmentArrange.startTime,
                                displayedComponents: .hourAndMinute
                            )
                            .datePickerStyle(.compact)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        HStack(spacing: 15) {
                            DatePicker(
                                "End Time",
                                selection: $vm.appointmentArrange.endTime,
                                displayedComponents: .hourAndMinute
                            )
                            .datePickerStyle(.compact)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        TextField("Search Location", text: $vm.appointmentArrange.location)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white.opacity(0.9))
                            )
                            .padding(.top, 15)
                            .onChange(of: vm.appointmentArrange.location) { newValue in
                                completer.queryFragment = newValue
                            }
                        
                        HStack(spacing: 15) {
                            Toggle("Remind", isOn: $vm.appointmentArrange.notify)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.top, 15)
                        
                        Button {
                            vm.saveAppointmentArrange()
                        } label: {
                            Text("Submit")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("BGBlue"))
                        .cornerRadius(10)
                        .padding(.top, 15)
                    }
                    .padding([.horizontal, .bottom], 20)
                    .padding(.top, 35)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
        
            if self.vm.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(
                        alert: self.$vm.message.alert,
                        error: self.$vm.message.error,
                        topic: self.$vm.message.topic,
                        loading: self.$vm.message.isLoading
                    )
                }
            }
        }
        .background(Color.gray.opacity(0.2))
    }
    
    func selectLocation(_ completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                selectedCoordinate = coordinate
                vm.appointmentArrange.location = completion.title

                print("Selected Location Lat: \(coordinate.latitude), Lng: \(coordinate.longitude)")
                // You can save these values in your view model too
            }
        }
    }
}

#Preview {
    AppointmentView()
}
