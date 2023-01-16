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
//                HStack {
//                    Text("About")
//                        .foregroundColor(.white)
//                        .font(.system(size: 40))
//                        .bold()
//                        .padding()
//                    Spacer()
//                }
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width*0.3, height: UIScreen.main.bounds.size.width*0.3, alignment: .center)
                Text("Outrageous Facts:")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                Text("History")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .bold()
                Text("Our app aims to provide a catalog of accurate and inspiring historical facts to encourage users to question and explore the history they think they know.")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(verbatim: "Contact us at solvusindustries@gmail.com")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(verbatim: "And lastly, please leave us a 5-star review! :)")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
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
