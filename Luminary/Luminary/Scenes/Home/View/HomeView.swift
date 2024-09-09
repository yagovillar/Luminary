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

                            ZStack (alignment: .trailing){
                                TextField("", text: $rss, prompt: Text("Paste  the RSS URL").foregroundStyle(Color(hex: "BAA89C")))
                                .foregroundStyle(Color(hex: "BAA89C"))
                            .textFieldStyle(CustomTextFieldStyle())

                             
                                Button(action: {
                                    viewModel.validate(url: rss)
                                }, label: {
                                    Image(uiImage: UIImage(named: "PlayButton") ?? UIImage())
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                })
                                .navigationDestination(isPresented: $viewModel.shouldNavigate) {
                                    DetailsView(viewModel: DetailsView.ViewModel(podcastService: PodcastService(), podcastUrl: rss))
                                }
                                .padding()

                            }
                            .frame(height: 72)
                        }
                        .frame(height: 112)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Recently Played")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(0..<10, id: \.self) { number in
                                    NavigationLink(destination: HomeView()) {
                                        RecentCell()
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                }
            }    
            .navigationBarModifier(backgroundColor: .clear, foregroundColor: .white, tintColor: .white, withSeparator: false)
            .navigationTitle("Add Podcasts")
            .toastView(toast: $viewModel.errorToast)
        }.isLoading(viewModel.isLoading)
    }
}

#Preview {
    HomeView()
}
