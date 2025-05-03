import SwiftUI
import GoogleMobileAds

public struct AdMobBannerView: UIViewRepresentable {
    @Binding var adState: AdState

    private let adSize: AdSize
    private let adUnitID: String

    public init(adSize: AdSize, adUnitID: String = "ca-app-pub-3940256099942544/2934735716", adState: Binding<AdState>) {
        self.adSize = adSize
        self.adUnitID = adUnitID
        _adState = adState
    }

    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.addSubview(context.coordinator.bannerView)
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.bannerView.adSize = adSize
        switch adState {
        case .idle:
            context.coordinator.bannerView.isHidden = true
        case .loading:
            context.coordinator.bannerView.isHidden = false
        case .loaded:
            context.coordinator.bannerView.isHidden = false
        case .error:
            context.coordinator.bannerView.isHidden = true
        }
        context.coordinator.bannerView.isUserInteractionEnabled = adState == .loaded
    }

    public func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }

    public class BannerCoordinator: NSObject, BannerViewDelegate {

        private(set) lazy var bannerView: BannerView = {
            let banner = BannerView(adSize: parent.adSize)
            banner.adUnitID = parent.adUnitID
            banner.load(Request())
            banner.delegate = self
            return banner
        }()

        let parent: AdMobBannerView

        init(_ parent: AdMobBannerView) {
            self.parent = parent
        }

        // MARK: - GADBannerViewDelegate methods

        public func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            parent.adState = .loaded
        }

        public func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            parent.adState = .error
        }
    }
}
