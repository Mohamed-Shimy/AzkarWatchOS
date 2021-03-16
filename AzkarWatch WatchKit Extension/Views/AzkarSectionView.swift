//
//  AzkarSectionView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Thu 17 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarSectionView : View
{
    @EnvironmentObject var store: AzkarStore
    
    var body: some View
    {
        VStack
        {
            SectionsToolsBar().padding([.horizontal, .top], 10)
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVGrid(columns: [GridItem()], spacing: 20)
                {
                    ForEach(store.getSections(), content: AzkarSectionCell.init)
                }
                .padding(.top, 10)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .padding(.horizontal)
        .islamicBackground()
    }
}

struct AzkarSectionView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    @ObservedObject private static var favoritesStore = FavoritesStore()
    
    static var previews: some View
    {
        NavigationView
        {
            AzkarSectionView()
                .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
        .environmentObject(store)
        .environmentObject(favoritesStore)
    }
}

struct AzkarSectionCell : View
{
    let section: Section
    
    var body: some View
    {
        NavigationLink(destination: AzkarSubSectionsView(section: section))
        {
            let size: CGFloat = 96
            Text(section.title)
                .font(.title3)
                .padding(10)
                .shadow(radius: 5)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .frame(width: size, height: size)
                .linearGradientBackground()
                .cornerRadius(15)
                .cellBackgroundStyle(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 5)
                .padding([.leading, .trailing], 20)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SectionsToolsBar : View
{
    @State private var isAboutViewPresented: Bool = false
    @State private var isFavoriteViewPresented: Bool = false
    
    var body: some View
    {
        HStack
        {
            Spacer()
            Button(action: presentFavoriteView)
            {
                Image(systemName: "suit.heart.fill")
                    .shadow(color: .background, radius: 2, x: 0, y: 0)
            }
            
            Button(action: presentAboutView)
            {
                Image(systemName: "info.circle.fill")
                    .shadow(color: .background, radius: 2, x: 0, y: 0)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.green)
        .sheet(isPresented: $isAboutViewPresented, content: { aboutLabel })
        .sheet(isPresented: $isFavoriteViewPresented, content: { FavoriteView() })
    }
    
    var aboutLabel: some View
    {
        Text("الأذكار")
            .padding(15)
            .font(.title2)
            .foregroundColor(.background)
            .multilineTextAlignment(.leading)
            .lineSpacing(10)
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.7).blur(radius: 5))
            .cornerRadius(10)
            .padding([.leading, .trailing], 10)
            .islamicBackground()
    }
    
    private func presentAboutView()
    {
        withAnimation
        {
            isAboutViewPresented.toggle()
        }
    }
    
    private func presentFavoriteView()
    {
        withAnimation
        {
            isFavoriteViewPresented.toggle()
        }
    }
}

extension View
{
    func islamicBackground() -> some View
    {
        self.background(Image("Backrgound").resizable()
                            .aspectRatio(contentMode: .fill).opacity(0.3)
                            .ignoresSafeArea())
    }
    
    func linearGradientBackground(_ colors: [Color] = [Color(hexa: 0xE0CC7C), .green],
                                  startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom,
                                  opacity: Double = 0.6) -> some View
    {
        self.background(LinearGradient(gradient: Gradient(colors: colors),
                                       startPoint: .top, endPoint: .bottom)
                            .opacity(opacity))
    }
    
    func cellBackgroundStyle<S: Shape>(_ shape: S) -> some View
    {
        self
            .overlay(shape.stroke(LinearGradient(gradient: Gradient(colors: [Color(hexa: 0xE0CC7C), .green]),
                                                 startPoint: .top, endPoint: .bottom), lineWidth: 0.5))
            .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 5)
    }
}
