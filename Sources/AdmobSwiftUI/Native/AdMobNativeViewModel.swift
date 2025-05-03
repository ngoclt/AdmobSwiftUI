import SwiftUI
import GoogleMobileAds

public class AdMobNativeViewModel: NSObject, ObservableObject, NativeAdLoaderDelegate {
    @Published public var nativeAd: NativeAd?
    @Published public var adState: AdState = .idle

    public var requestInterval: Int

    private var adLoader: AdLoader!
    private var adUnitID: String
    private var lastRequestTime: Date?

    private static var cachedAds: [String: NativeAd] = [:]
    private static var lastRequestTimes: [String: Date] = [:]
    
    public init(adUnitID: String = "ca-app-pub-3940256099942544/3986624511", requestInterval: Int = 1 * 60) {
        self.adUnitID = adUnitID
        self.requestInterval = requestInterval
        self.nativeAd = AdMobNativeViewModel.cachedAds[adUnitID]
        self.lastRequestTime = AdMobNativeViewModel.lastRequestTimes[adUnitID]
    }
    
    public func refreshAd() {
        let now = Date()
        
        if nativeAd != nil, let lastRequest = lastRequestTime, now.timeIntervalSince(lastRequest) < Double(requestInterval) {
            print("The last request was made less than \(requestInterval / 60) minutes ago. New request is canceled.")
            return
        }
        
        guard adState != .loading else {
            print("Previous request is still loading, new request is canceled.")
            return
        }
        
        adState = .loading
        lastRequestTime = now
        AdMobNativeViewModel.lastRequestTimes[adUnitID] = now
        
        let adViewOptions = NativeAdViewAdOptions()
        adViewOptions.preferredAdChoicesPosition = .topRightCorner
        adLoader = AdLoader(adUnitID: adUnitID, rootViewController: nil, adTypes: [.native], options: [adViewOptions])
        adLoader.delegate = self
        adLoader.load(Request())
    }
    
    public func adLoader(_ adLoader:AdLoader, didReceive nativeAd: NativeAd) {
        self.nativeAd = nativeAd
        nativeAd.delegate = self

        adState = .loaded
        AdMobNativeViewModel.cachedAds[adUnitID] = nativeAd
        nativeAd.mediaContent.videoController.delegate = self
    }
    
    public func adLoader(_ adLoader:AdLoader, didFailToReceiveAdWithError error: Error) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
        adState = .error
    }
}

extension AdMobNativeViewModel: VideoControllerDelegate {

    public func videoControllerDidPlayVideo(_ videoController:VideoController) {
        // Implement this method to receive a notification when the video controller
        // begins playing the ad.
    }
    
    public func videoControllerDidPauseVideo(_ videoController:VideoController) {
        // Implement this method to receive a notification when the video controller
        // pauses the ad.
    }
    
    public func videoControllerDidEndVideoPlayback(_ videoController:VideoController) {
        // Implement this method to receive a notification when the video controller
        // stops playing the ad.
    }
    
    public func videoControllerDidMuteVideo(_ videoController:VideoController) {
        // Implement this method to receive a notification when the video controller
        // mutes the ad.
    }
    
    public func videoControllerDidUnmuteVideo(_ videoController:VideoController) {
        // Implement this method to receive a notification when the video controller
        // unmutes the ad.
    }
}

extension AdMobNativeViewModel: NativeAdDelegate {

    public func nativeAdDidRecordClick(_ nativeAd: NativeAd) {
        print("\(#function) called")
    }
    
    public func nativeAdDidRecordImpression(_ nativeAd: NativeAd) {
        print("\(#function) called")
    }
    
    public func nativeAdWillPresentScreen(_ nativeAd: NativeAd) {
        print("\(#function) called")
    }
    
    public func nativeAdWillDismissScreen(_ nativeAd: NativeAd) {
        print("\(#function) called")
    }
    
    public func nativeAdDidDismissScreen(_ nativeAd: NativeAd) {
        print("\(#function) called")
    }
}
