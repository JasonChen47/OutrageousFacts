//
//  BannerVC.swift
//  Outrageous Facts
//
//  Created by John Smith on 1/14/23.
//

import Foundation
import GoogleMobileAds
import SwiftUI
import UIKit

struct GADBannerViewController: UIViewControllerRepresentable {

    @State private var banner: GADBannerView = GADBannerView(adSize: GADAdSizeBanner)
    let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.size.width, height: 50))

    func makeUIViewController(context: Context) -> UIViewController {
        
        let bannerSize = adSize
        let viewController = UIViewController()
        banner.adSize = bannerSize
        banner.adUnitID = "ca-app-pub-2473443487936328/6644981588"
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.load(GADRequest())
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        let bannerSize = adSize
        banner.frame = CGRect(origin: .zero, size: bannerSize.size)
        banner.load(GADRequest())
    }
}



struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            GADBannerViewController()
                .frame(width: UIScreen.main.bounds.size.width, height: 50)
        }
    }
}
