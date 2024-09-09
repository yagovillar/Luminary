//
//  HomeView.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

import SwiftUI

struct HomeView: View {
    @State private var rss = ""
    @State private var viewModel = ViewModel(podcastService: PodcastService())
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            ZStack{
                Color(hex: "171412").ignoresSafeArea()
                VStack{
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("RSS")
                                .font(.headline)
                                .foregroundStyle(.white)

                            TextField("", text: $rss, prompt: Text("Paste  the RSS URL").foregroundStyle(Color(hex: "BAA89C")))
                            .foregroundStyle(Color(hex: "BAA89C"))
                                .textFieldStyle(CustomTextFieldStyle())
                                .onChange(of: $rss) { _ in
                                        validateURL()
                                    }
                        }
                        .frame(height: 112)

                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.system(.subheadline))
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Recently Played")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(0..<10, id: \.self) { number in
                                    RecentCell().padding(.vertical, 5)
                                }
                            }
                        }
                    }.padding(.top, 30)
                        .padding()
                    
                    Spacer()
                    
                }
            }    
            .navigationBarModifier(backgroundColor: .clear, foregroundColor: .white, tintColor: .white, withSeparator: false)
            .navigationTitle("Add Podcasts")
            .onAppear(perform: {
            })
        }
    }
}

#Preview {
    HomeView()
}
