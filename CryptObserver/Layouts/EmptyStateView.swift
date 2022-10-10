//
//  EmptyStateView.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemFill)
            VStack {
                Image(systemName: "text.magnifyingglass")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .bold()
                    .padding(.bottom)
                Text("No result")
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .font(.custom("Arial Rounded MT Bold", size: 30))
                    .bold()
            }
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
