//
//  SceneDelegate.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import UIKit
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

  var secondaryWindow: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
      if let windowScene = scene as? UIWindowScene {
          setupSecondaryOverlayWindow(in: windowScene)
      }
  }

  func setupSecondaryOverlayWindow(in scene: UIWindowScene) {
      let secondaryViewController = UIHostingController(
          rootView:
              EmptyView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .modifier(InAppNotificationViewModifier())
      )
      secondaryViewController.view.backgroundColor = .clear
    let secondaryWindow = PassThroughWindow(windowScene: scene)
    secondaryWindow.rootViewController = secondaryViewController
    secondaryWindow.isHidden = false
    self.secondaryWindow = secondaryWindow
  }
}

class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint,
                        with event: UIEvent?) -> UIView? {
    guard let hitView = super.hitTest(point, with: event)
    else { return nil }

    return rootViewController?.view == hitView ? nil : hitView
  }
}

struct InAppNotificationViewModifier: ViewModifier {
    @State private var isSheetPresented: Bool = false
    @State private var isNavigating: Bool = false
    @State private var currentDetent: PresentationDetent = .height(120)
    
    func body(content: Content) -> some View {
        content
            .overlay {
                // Overlay content if needed
            }
            .sheet(isPresented: $isSheetPresented) {
                NavigationStack {
                    VStack {
                        if currentDetent == .large {
                            // Navigate to PlayerView
                            PlayerView(viewModel: PlayerView.ViewModel(episode: AudioPlayer.shared.episode))
                                .transition(.move(edge: .bottom)) // Optional: Add transition effect
                        } else {
                            TabBarPlayerWrapper(isNavigating: $isNavigating, currentDetent: $currentDetent)
                        }
                    }
                }
                .interactiveDismissDisabled()
                .presentationDetents([.height(120), .large], selection: $currentDetent)
                .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
            }
            .onChange(of: AudioPlayer.shared.player) { newPlayer in
                // Show the sheet if player is not nil
                isSheetPresented = newPlayer != nil
            }
    }
}

struct TabBarPlayerWrapper: View {
    @Binding var isNavigating: Bool
    @Binding var currentDetent: PresentationDetent

    var body: some View {
        VStack {
            TabBarPlayerView()
                .frame(height: 120)
                .onTapGesture {
                    isNavigating = true
                    currentDetent = .large
                }
        }
    }
}
