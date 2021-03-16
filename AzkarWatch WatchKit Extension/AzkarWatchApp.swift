//
//  AzkarWatchApp.swift
//  AzkarWatch WatchKit Extension
//
//  Created by Mohamed Shemy on Sun 14 Mar 2021.
//

import SwiftUI

@main
struct AzkarWatchApp: App
{
    @StateObject private var azkarStore = AzkarStore()
    @StateObject private var favoritesStore = FavoritesStore()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene
    {
        WindowGroup
        {
            NavigationView
            {
                AzkarSectionView()
            }
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environment(\.managedObjectContext, favoritesStore.context)
            .environmentObject(azkarStore)
            .environmentObject(favoritesStore)
        }
        .onChange(of: scenePhase, perform: handelScenePhase)
    }
    
    private func handelScenePhase(_ phase:  ScenePhase)
    {
        switch phase
        {
            case .background: PersistenceController.favorites.save()
            default: break
        }
    }
}
