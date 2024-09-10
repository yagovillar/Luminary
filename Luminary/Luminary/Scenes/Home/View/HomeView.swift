//
//  HomeView.swift
//  Luminary
//
//  Created by Yago Vanzan on 07/09/24.
//

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
    @State private var showPlayer = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "171412").ignoresSafeArea()
                
                VStack {
                    RSSInputView(rss: $rss, validateAction: {
                        viewModel.validate(url: rss)
                    })
                    .padding()
                    
                    RecentlyPlayedView()
                        .padding()
                    
                    Spacer()
                }
            }
            .navigationBarModifier(
                backgroundColor: .clear,
                foregroundColor: .white,
                tintColor: .white,
                withSeparator: false
            )
            .navigationTitle("Add Podcasts")
            .toastView(toast: $viewModel.errorToast)
            .navigationDestination(isPresented: $viewModel.shouldNavigate) {
                DetailsView(viewModel: DetailsView.ViewModel(podcastService: PodcastService(), podcastUrl: rss))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    checkPlayerStatus()
                })
            }
            .sheet(isPresented: $showPlayer, content: {
                TabBarPlayerView()
                    .interactiveDismissDisabled()
                    .presentationDetents([.height(120)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
            })
        }
        .isLoading(viewModel.isLoading)
    }
    
    
    private func checkPlayerStatus() {
        if AudioPlayer.shared.player != nil {
            showPlayer = true
        }
    }
}

struct RSSInputView: View {
    @Binding var rss: String
    var validateAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("RSS")
                .font(.headline)
                .foregroundStyle(.white)
            
            ZStack(alignment: .trailing) {
                TextField("", text: $rss, prompt: Text("Paste the RSS URL").foregroundStyle(Color(hex: "BAA89C")))
                    .foregroundStyle(Color(hex: "BAA89C"))
                    .textFieldStyle(CustomTextFieldStyle())
                
                Button(action: validateAction, label: {
                    Image(uiImage: UIImage(named: "PlayButton") ?? UIImage())
                        .resizable()
                        .frame(width: 30, height: 30)
                })
                .padding()
            }
            .frame(height: 72)
        }
        .frame(height: 112)
    }
}

struct RecentlyPlayedView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Played")
                .font(.headline)
                .foregroundStyle(.white)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<10, id: \.self) { _ in
                        NavigationLink(destination: HomeView()) {
                            RecentCell()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
