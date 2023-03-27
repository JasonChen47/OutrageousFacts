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
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width*0.3, height: UIScreen.main.bounds.size.width*0.3, alignment: .center)
                Text("Historical Facts")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .bold()
                Text("Our app aims to provide a catalog of accurate and inspiring historical facts to encourage users to question and explore the history they think they know.")
                    .foregroundColor(.white)
                    .font(.system(size: bodyTextSize))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(verbatim: "Contact us at solvusindustries@gmail.com")
                    .foregroundColor(.white)
                    .font(.system(size: bodyTextSize))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(verbatim: "References at https://tinyurl.com/historyfactsreferences")
                    .foregroundColor(.white)
                    .font(.system(size: bodyTextSize))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(verbatim: "Also, if you have time, please leave us a 5-star review! :)")
                    .foregroundColor(.white)
                    .font(.system(size: bodyTextSize))
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(gradientStart: Color.cyan, gradientEnd: Color.green)
    }
}
