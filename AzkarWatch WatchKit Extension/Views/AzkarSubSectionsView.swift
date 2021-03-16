//
//  SubSectionsView.swift
//  iPrayUI
//
//  Created by Mohamed Shemy on Fri 18 Dec 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct AzkarSubSectionsView : View
{
    let section: Section
    @EnvironmentObject var store: AzkarStore
    
    var body: some View
    {
        VStack
        {
            toolBar.padding([.horizontal, .top], 10)
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVStack(spacing: 15)
                {
                    Text(section.title).multilineTextAlignment(.center)
                    ForEach(store[section], content: AzkarSubSectionCell.init)
                }
                .padding(.top, 10)
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
        .navigationBarHidden(true)
        .islamicBackground()
    }
    
    private var toolBar: some View
    {
        HStack
        {
            Spacer()
            BackButton()
        }
    }
}

struct AzkarSubSectionsView_Previews : PreviewProvider
{
    @ObservedObject private static var store = AzkarStore()
    
    static var previews: some View
    {
        AzkarSubSectionsView(section: store[7])
            .environment(\.layoutDirection, .rightToLeft)
            .environment(\.locale, Locale(identifier: "ar"))
            .environmentObject(store)
    }
}

struct AzkarSubSectionCell : View
{
    let subSection: SubSection
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: subSection))
        {
            Text(subSection.title)
                .padding(10)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, minHeight: 32)
                .appBackgroundLinearGradient()
                .clipShape(Capsule())
                .padding([.leading, .trailing], 10)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
