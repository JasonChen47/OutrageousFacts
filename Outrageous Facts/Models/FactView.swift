//
//  FactView.swift
//  Outrageous Facts
//
//  Created by John Smith on 12/29/22.
//

import SwiftUI
import GoogleMobileAds
import UIKit

struct FactView: View {
    
    @State private var randColorIdx1 = Int.random(in: 0...colorArr.count-1)
    @State private var randColorIdx2 = Int.random(in: 0...colorArr.count-1)
    @State private var isPresentingEditView = false
    @State private var quote = RandQuote.getQuote()
    @State private var APIQuoteGen = APIRequest(quoteArr: [])
    
    var body: some View {
        let gradientStart = FactView.colorArr[randColorIdx1]
        let gradientEnd = FactView.colorArr[randColorIdx2]
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    HStack{
                        // About page
                        Spacer()
                        Button(action: {
                            isPresentingEditView = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                        .sheet(isPresented: $isPresentingEditView) {
                            NavigationView {
                                AboutView(gradientStart: gradientStart, gradientEnd: gradientEnd)
                                    .toolbar {
                                        ToolbarItem(placement: .confirmationAction) {
                                            Button("Done") {
                                                isPresentingEditView = false
                                            }
                                            .foregroundColor(.white)
                                        }
                                    }
                            }
                        }
                    }
                    Spacer()
                    // Historical fact
                    Text(quote)
                        .foregroundColor(.white)
                        .font(.system(size: 21))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width*0.85, height: UIScreen.main.bounds.size.width*0.85, alignment: .center)
                    Spacer()
                    // Button for random fact
                    HStack {
                        Button(action: {
                            APIQuoteGen.checkFillArr()
                            quote = APIQuoteGen.quickQuote()
                            // Change the gradient colors
                            DispatchQueue.main.async {
                                randColorIdx1 = Int.random(in: 0...FactView.colorArr.count-1)
                                randColorIdx2 = Int.random(in: 0...FactView.colorArr.count-1)
                            }
                        }) {
                            Image(systemName: "rectangle.3.group.bubble.left")
                        }
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    Spacer()
                }
                .padding()
            }

            // Advertisement
            VStack {
                GADBannerViewController()
                    .frame(width: UIScreen.main.bounds.size.width, height: 50)
                Spacer()
            }
        }
        // Background
        .background(
            ZStack {
                // Image
                Image("Pyramid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center)
                // Darkness shade
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                // Circle
                VStack {
                    HStack {
                        Circle()
                            .strokeBorder(lineWidth: 15)
                            .foregroundColor(.white)
                            .padding(5)
                            .opacity(0.7)
                    }
                }
                // Gradient colors
                Rectangle().fill(.linearGradient(
                    Gradient(colors:[gradientStart, gradientEnd]),
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 0.6)
                ))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.4)
            }
        )
    }
    static let colorArr = [Color(.yellow), Color(.blue), Color(.red), Color(.green), Color(.orange), Color(.purple), Color(.cyan)]
}



struct FactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FactView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
