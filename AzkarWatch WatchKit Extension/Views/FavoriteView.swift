//
//  FavoriteView.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 4 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct FavoriteView : View
{
    @EnvironmentObject var store: FavoritesStore
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            BackButton().padding([.horizontal, .top], 5)
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVStack(spacing: 15)
                {
                    ForEach(store.favorites){ fav in FavoriteCell(favorite: fav) }
                        .onDelete(perform: deleteItems)
                }
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
        .navigationBarHidden(true)
        .islamicBackground()
    }
    
    private func deleteItems(offsets: IndexSet)
    {
        withAnimation
        {
            store.delete(offsets: offsets)
        }
    }
}

struct FavoriteView_Previews : PreviewProvider
{
    static var previews: some View
    {
        FavoriteView()
            .environmentObject(FavoritesStore())
            .environmentObject(AzkarStore())
    }
}

struct FavoriteCell : View
{
    let favorite: Favorite
    @EnvironmentObject var azkarStore: AzkarStore
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: azkarStore.getSubSection(for: favorite)))
        {
            Text(favorite.title ?? "")
                .padding(10)
                .font(.title)
                .minimumScaleFactor(0.5)
                .foregroundColor(.background)
                .lineLimit(1)
                .frame(maxWidth: .infinity, minHeight: 64)
                .padding([.horizontal, .top], 10)
                .clipShape(Capsule())
                .padding([.leading, .trailing], 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
