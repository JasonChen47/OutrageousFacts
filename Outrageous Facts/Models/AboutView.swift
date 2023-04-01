//
//  AboutView.swift
//  Outrageous Facts
//
//  Created by John Smith on 1/15/23.
//

import SwiftUI

struct AboutView: View {
    var gradientStart: Color
    var gradientEnd: Color
    var bodyTextSize: CGFloat = 18
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Rectangle().fill(.linearGradient(
                Gradient(colors:[gradientStart, gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.7)
            VStack {
                Image("Ship")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width*0.3, height: UIScreen.main.bounds.size.width*0.3, alignment: .center)
                    .opacity(0.7)
                Text("Historical Facts")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .bold()
                Text("Our app aims to provide a catalog of accurate and inspiring historical facts to encourage users to question and explore the history they think they know.")
                    .foregroundColor(.white)
                    .font(.system(size: bodyTextSize))
                    .padding()
                    .multilineTextAlignment(.center)
                VStack {
                    Text(verbatim: "Contact us at")
                        .foregroundColor(.white)
                        .font(.system(size: bodyTextSize))                        .multilineTextAlignment(.center)
                    Link("solvusindustries@gmail.com", destination: URL(string: "mailto:solvusindustries@gmail.com")!)
                }
                .padding()
                VStack {
                    Text(verbatim: "References at")
                        .foregroundColor(.white)
                        .font(.system(size: bodyTextSize))
                        .multilineTextAlignment(.center)
                    Link("https://tinyurl.com/historyfactsreferences", destination: URL(string: "https://tinyurl.com/historyfactsreferences")!)
                }
                .padding()
                VStack {
                    Text(verbatim: "Please leave us a 5-star review!")
                        .foregroundColor(.white)
                        .font(.system(size: bodyTextSize))
                        
                        .multilineTextAlignment(.center)
                    Link("Link to app store", destination: URL(string: "https://apps.apple.com/us/app/historical-facts/id1665761564")!)
                }
                .padding()
                
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(gradientStart: Color.cyan, gradientEnd: Color.green)
    }
}
