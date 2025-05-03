import GoogleMobileAds
import SwiftUI

public enum AdMobNativeViewStyle {
    case basic
    case card
    case banner
    case largeBanner
    
    var view: NativeAdView {
        switch self {
        case .basic:
            return makeNibView(name: "NativeAdView")
        case .card:
            return AdMobNativeCardView(frame: .zero)
        case .banner:
            return AdMobNativeBannerView(frame: .zero)
        case .largeBanner:
            return AdMobNativeLargeBannerView(frame: .zero)
        }
    }
    
    func makeNibView(name: String) -> NativeAdView {
        let bundle = Bundle.module
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as!NativeAdView
    }
}
