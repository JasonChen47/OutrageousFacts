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
    
    var quoteData: [Quote] = Quote.sampleData
    @State private var randIdx = Int.random(in: 0...Quote.sampleData.count-1)
    @State private var randColorIdx1 = Int.random(in: 0...colorArr.count-1)
    @State private var randColorIdx2 = Int.random(in: 0...colorArr.count-1)
    @State private var isPresentingEditView = false
    
    var body: some View {
        let quoteCount = quoteData.count
        let quote: String = quoteData[randIdx].quote
        let gradientStart = FactView.colorArr[randColorIdx1]
        let gradientEnd = FactView.colorArr[randColorIdx2]
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Circle()
                        .strokeBorder(lineWidth: 15)
                        .foregroundColor(.white)
                        .padding(5)
                        .opacity(0.7)
                }
            }
            Rectangle().fill(.linearGradient(
                Gradient(colors:[gradientStart, gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.7)
            HStack {
                VStack {
                    Spacer()
                    HStack{
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
                    Text(quote)
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: UIScreen.main.bounds.size.width*0.9, height: UIScreen.main.bounds.size.width*0.9, alignment: .center)
                    Spacer()
                    HStack {
                        
                        Button(action: {
                            randIdx = Int.random(in: 0...quoteCount-1)
                            randColorIdx1 = Int.random(in: 0...FactView.colorArr.count-1)
                            randColorIdx2 = Int.random(in: 0...FactView.colorArr.count-1)
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
            VStack {
                HStack {
                    GADBannerViewController()
                        .frame(width: UIScreen.main.bounds.size.width, height: 50)
                }
                Spacer()
            }
        }
    }
    static let colorArr = [Color(.yellow), Color(.blue), Color(.red), Color(.green), Color(.orange), Color(.purple), Color(.cyan)]
}



struct FactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FactView(quoteData: Quote.sampleData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
