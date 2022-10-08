//
//  ConectionErrorScreen.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct ConectionErrorScreen: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AssetsListViewModel
    let message: String

    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemFill)
            VStack {
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .frame(width: 120, height: 90)
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .bold()
                    .padding(.bottom)

                Text(viewModel.errorTitle)
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .font(.custom("Arial Rounded MT Bold", size: 30))
                    .bold()
                    .padding()
                
                Text(message)
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .padding(.bottom, 50)

                Button {
                    print(">> retry button pressed")
                    viewModel.fetchAssets()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .fontWeight(.semibold)
                        Text("Retry")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 83.5)
                    .padding(.vertical, 14)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ConectionErrorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ConectionErrorScreen(message: "No internet connection, please try again later")
    }
}
