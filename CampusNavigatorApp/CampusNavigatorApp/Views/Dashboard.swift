//
//  Dashboard.swift
//  CampusNavigatorApp
//

import SwiftUI

struct DashboardView: View {
    @State private var showTourGuide = false
    @State private var userName = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                // Background
                BackgroundView()
                
                // Main content
                VStack(spacing: 0) {
                    // Header
                    HeaderView(userName: userName)
                    
                    // Main title
                    MainTitleView()
                    
                    // Navigation buttons
                    NavigationButtonsView()
                    
                    Spacer()
                }
                
                // Chatbot button (floating)
                ChatbotButtonView()
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 110)
                
                // Tour guide overlay
                if showTourGuide {
                                TourGuideOverlayView(onComplete: {
                                    showTourGuide = false
                                    UserDefaults.standard.completeTour()
                                })
                            }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                loadUserData()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func loadUserData() {
        userName = UserDefaults.standard.getUsername()
        showTourGuide = UserDefaults.standard.isFirstHomePageVisit()
    }

}

#Preview {
    DashboardView()
}
