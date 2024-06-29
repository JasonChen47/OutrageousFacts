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
    
    static let shared = FactView()
    
    @State private var randColorIdx1 = Int.random(in: 0...colorArr.count-1)
    @State private var randColorIdx2 = Int.random(in: 0...colorArr.count-1)
    @State private var isPresentingEditView = false
    @State private var quote = RandQuote.getQuote()
    @State private var APIQuoteGen = APIRequest(quoteArr: [RandQuote.getQuote(), RandQuote.getQuote()], linkArr: ["", ""])
    @State var backgroundString = "City"
    @State private var selectedPageIndex = 0
    @State private var oldSelectedPageIndex = 0
    @State private var testString = ""
    @State private var toShowAlert : Bool = false
    @State private var refreshScreen: Bool = true
//    @State var scrolledID: Int?
    @State var scrolledID: Int? = 0
    
    var body: some View {
        let gradientStart = FactView.colorArr[randColorIdx1]
        let gradientEnd = FactView.colorArr[randColorIdx2]
        let screenWidth = UIScreen.main.bounds.size.width
        let dateDay = Calendar.current.component(.day, from: Date())
        let pub = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay)))
        let pub2 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 1)))
        let pub3 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 2)))
        let pub4 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 3)))
        let pub5 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 4)))
        let pub6 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 5)))
        let pub7 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 6)))
        let pub8 = NotificationCenter.default.publisher(
                           for: NSNotification.Name("com.historicalfacts.notif.id" + String(dateDay - 7)))
        
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
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding()
                                .background(
                                    Color.clear
                                        .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                        .opacity(0.3)
                                    )
                        }
                        Button(action: {
                            backgroundString = "Pyramid"
                        }) {
                            Image(systemName: "sun.dust")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding()
                                .background(
                                    Color.clear
                                        .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                        .opacity(0.3)
                                    )
                        }
                        Button(action: {
                            backgroundString = "Temple"
                        }) {
                            Image(systemName: "mountain.2")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding()
                                .background(
                                    Color.clear
                                        .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                        .opacity(0.3)
                                    )
                        }
                        // About page
                        Spacer()
                        Button(action: {
                            isPresentingEditView = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 28))
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
                    // Link to learn more
                    if (APIQuoteGen.linkArr[scrolledID ?? 0] != "") {
                        Link("Learn More", destination: URL(string: "\(APIQuoteGen.linkArr[scrolledID ?? 0])")!)
                            .foregroundColor(.white)
                            .padding(7)
                            .background(
                                Color.clear
                                    .overlay(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                                    .opacity(0.3)
                            )
                            .padding()
                    }
                }
            }
        }
        .onAppear{
            APIQuoteGen.addFact()
            NotificationHandler.shared.requestPermission( onDeny: {
                self.toShowAlert.toggle()
            })
            if NotificationHandler.shared.contentBody != "" {
                print("13684")
                APIQuoteGen.quoteArr = [NotificationHandler.shared.contentBody]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                print("received pub")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
//                // Add fact if start with index 0 because it won't add during task for some reason
//                if selectedPageIndex == 0 {
//                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
//                    APIQuoteGen.linkArr.append("")
//                }
//                // If you start at index 0, it won't register a change, so do this to ensure change is registered
//                selectedPageIndex = -1
//                selectedPageIndex += 1
                scrolledID = 0
                // Add fact if start with index 0 because it won't add during task for some reason
                if scrolledID == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
//                scrolledID = -1
//                scrolledID += 1
//                scrolledID = 0
//                APIQuoteGen.addFact()
//                APIQuoteGen.addFact()
            }
        }
        .onReceive(pub2){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub3){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub4){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub5){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub6){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub7){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        .onReceive(pub8){ data in
            // execute other methods when the
            // Combine publisher with the specified
            // name received
            if let content = (data.object as? UNNotificationContent){
                print("title:\(content.title), subtitle:\(content.body)")
                APIQuoteGen.quoteArr = [content.body]
                APIQuoteGen.linkArr = [""]
                // Add fact if start with index 0 because it won't add during task for some reason
                if selectedPageIndex == 0 {
                    APIQuoteGen.quoteArr.append(RandQuote.getQuote())
                    APIQuoteGen.linkArr.append("")
                }
                // If you start at index 0, it won't register a change, so do this to ensure change is registered
                selectedPageIndex = -1
                selectedPageIndex += 1
            }
        }
        // Start adding async fact
        .task {
            APIQuoteGen.addFact()
            APIQuoteGen.quoteArr.append(RandQuote.getQuote())
            APIQuoteGen.linkArr.append("")
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
//                Text(quote)
//                    .foregroundColor(.white)
//                    .font(.system(size: 20))
//                    .multilineTextAlignment(.center)
//                    .padding()
//                    .frame(width: screenWidth*0.85, height: screenWidth*0.85, alignment: .center)
                // Historical fact with paging
                
                
                GeometryReader { geo in
                    if #available(iOS 17.0, *) {
                        ScrollView (.horizontal) {
                            HStack (spacing: 0) {
                                ForEach(Array(APIQuoteGen.quoteArr.enumerated()), id: \.offset) { index, fact in
                                    Text(fact)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .multilineTextAlignment(.center)
                                        .padding(geo.size.width*0.1)
                                        .frame(width: geo.size.width, height: geo.size.height)
//                                        .tag(index)
//                                    Text("View: \(index)")
//                                        .frame(width: geo.size.width, height: geo.size.height)
//                                        .id(index)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollPosition(id: $scrolledID)
                        .scrollTargetBehavior(.paging)
                        .onChange(of: scrolledID) {
                            APIQuoteGen.addFact()
                            randColorIdx1 = Int.random(in: 0...FactView.colorArr.count-1)
                            randColorIdx2 = Int.random(in: 0...FactView.colorArr.count-1)
                        }
                    } else {
                        // Fallback on earlier versions
                    }  //  <----
                }
//                TabView(selection: $selectedPageIndex) {
//                    ForEach(Array(APIQuoteGen.quoteArr.enumerated()), id: \.element) { index, fact in
//                        Text(fact)
//                            .foregroundColor(.white)
//                            .font(.system(size: 20))
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .frame(width: screenWidth*0.85, height: screenWidth*0.85, alignment: .center)
//                            .tag(index)
//                    }
//                }
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                .onChange(of: selectedPageIndex) { newValue in
//                    // Only add if you reach an index greater than 2 less than the end of the array and swiping right
////                    if APIQuoteGen.quoteArr.count < 3 {
////                        APIQuoteGen.quoteArr.append(RandQuote.getQuote())
////                        APIQuoteGen.linkArr.append("")
////                    }
////                    if newValue > (APIQuoteGen.quoteArr.count - 4)
////                        && newValue > oldSelectedPageIndex
////                    {
////                        // Generate new quote at end of array
////                        APIQuoteGen.addFact()
////                        testString = "added"
////                    }
////                    else {
////                        testString = "nope"
////                    }
////                    // To determine if swiping right
////                    oldSelectedPageIndex = newValue
//                    // Color change
//                    APIQuoteGen.addFact()
//                    randColorIdx1 = Int.random(in: 0...FactView.colorArr.count-1)
//                    randColorIdx2 = Int.random(in: 0...FactView.colorArr.count-1)
//                }
                
                
//                // VStack for debugging
//                VStack {
//                    Text(testString)
//                    Text("\(selectedPageIndex)")
//                    Text("\(APIQuoteGen.quoteArr.count)")
//                    Text("\(oldSelectedPageIndex)")
//                }
                
                
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
    static var text = "hi"
    static var previews: some View {
        NavigationView {
            FactView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
