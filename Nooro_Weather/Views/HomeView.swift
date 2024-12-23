//
//  HomeView.swift
//  Nooro_Weather
//
//  Created by Jerry Walton on 12/23/24.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var navigateToSearch: Bool = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                SearchBar(text: $searchText, placeholder: "Search Location")
                    .onSubmit {
                        navigateToSearch = true
                    }

                if let weather = viewModel.cityWeather {
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: "https:" + weather.current.condition.icon)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.white
                        }
                        .frame(width: 128, height: 128)
                        
                        Text(weather.location.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text("\(Int(weather.current.temp_c))°C")
                            .font(.system(size: 72))
                            .bold()
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 10) {
                                Text("Humidity")
                                    .foregroundColor(Color(.systemGray3))
                                Text("\(weather.current.humidity)%")
                                    .foregroundColor(Color(.systemGray))
                            }
                            .padding()
                            VStack(spacing: 10) {
                                Text("UV")
                                    .foregroundColor(Color(.systemGray3))
                                Text("\(weather.current.uv.formatted(.number.rounded(rule: .awayFromZero, increment: 1)))")
                                    .foregroundColor(Color(.systemGray))
                            }
                            .padding()
                            VStack(spacing: 10) {
                                Text("Feels Like")
                                    .foregroundColor(Color(.systemGray3))
                                Text("\(weather.current.feelslike_c.formatted(.number.rounded(rule: .awayFromZero, increment: 1)))°C")
                                    .foregroundColor(Color(.systemGray))
                            }
                            .padding()
                        }
                        .contentMargins(20)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                } else {
                    VStack(spacing: 16) {
                        Text("No City Selected")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        Text("Please Search For A City")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.black)
                    }
                }

            }
            .padding()
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $navigateToSearch) {
                SearchResultsView(searchText: searchText) {
                    navigateToSearch = false
                }
            }
        }
    }
}

struct SearchResultsView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State var searchText: String
    var onCitySelected: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Location")
                    .onSubmit {
                        performSearch()
                    }
                    .onAppear {
                        performSearch()
                    }
                if viewModel.searchResults != nil {
                    List {
                        Button(action: {
                            viewModel.cityWeather = viewModel.searchResults
                            onCitySelected()
                        }) {
                            HStack() {
                                VStack(spacing: 10) {
                                    Text((viewModel.searchResults?.location.name)!)
                                        .font(.largeTitle)
                                        .bold()
                                    
                                    Text("\(Int((viewModel.searchResults?.current.temp_c)!))°C")
                                        .font(.system(size: 72))
                                        .bold()
                                }
                                
                            }
                            AsyncImage(url: URL(string: "https:" + (viewModel.searchResults?.current.condition.icon)!)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.white
                            }
                            .frame(width: 64, height: 64)
                        }
                    }
                } else {
                    
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func performSearch() {
        viewModel.searchWeather(for: searchText)
    }
}

struct SearchBar: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var text: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}


