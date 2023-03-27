//
//  FactView.swift
//  Outrageous Facts
//
//  Created by John Smith on 12/29/22.
//

import SwiftUI
import GoogleMobileAds
import UIKit
import SnapToScroll
import ScrollViewStyle

struct FactView: View {
    
    @State private var randColorIdx1 = Int.random(in: 0...colorArr.count-1)
    @State private var randColorIdx2 = Int.random(in: 0...colorArr.count-1)
    @State private var isPresentingEditView = false
    @State private var quote = RandQuote.getQuote()
    @State private var APIQuoteGen = APIRequest(quoteArr: [])
    @State private var backgroundString = "City"

    var body: some View {
        let gradientStart = FactView.colorArr[randColorIdx1]
        let gradientEnd = FactView.colorArr[randColorIdx2]
        let screenWidth = UIScreen.main.bounds.size.width
        
        ZStack {
            HStack {
                VStack {
                    // Advertisement
                    VStack {
                        GADBannerViewController()
                            .frame(width: screenWidth, height: 50)
                    }
                    HStack{
                        // Change background
                        Button(action: {
                            backgroundString = "City"
                        }) {
                            Image(systemName: "building.2")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .padding()
                        .background(
                            Color.clear
                                .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                .opacity(0.3)
                        )
                        Button(action: {
                            backgroundString = "Pyramid"
                        }) {
                            Image(systemName: "sun.haze")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .padding()
                        .background(
                            Color.clear
                                .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                .opacity(0.3)
                        )
                        Button(action: {
                            backgroundString = "Temple"
                        }) {
                            Image(systemName: "mountain.2")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .padding()
                        .background(
                            Color.clear
                                .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                .opacity(0.3)
                        )
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
                    .padding()
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
                }
            }
            
        }
        // Background
        .background(
            ZStack {
                // Image
                Image(backgroundString)
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
                            .strokeBorder(lineWidth: 10)
                            .foregroundColor(.white)
                            .frame(width: screenWidth*0.95, height: screenWidth*0.95, alignment: .center)
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
                // Historical fact
                Text(quote)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: screenWidth*0.85, height: screenWidth*0.85, alignment: .center)
            }
        )
    }
    static let colorArr = [Color(.yellow), Color(.blue), Color(.red), Color(.green), Color(.orange), Color(.purple), Color(.cyan)]
}

// To obtain the place that you scrolled to
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct FactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FactView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
